#!/usr/bin/env coffee
GetOpt=require '@kssfilo/getopt'
Fs=require 'fs'
Path=require 'path'
Norl=require 'norl'
AppName="@PARTPIPE@BINNAME@PARTPIPE@"
PackageName="@PARTPIPE@NAME@PARTPIPE@"

P=console.log
O=(s)=>process.stdout.write s,s.length
E=(e)=>
	switch
		when typeof(e) in ['string','value']
			console.error e
		when ctx.isDebugMode
			console.error e
		else
			if e[0]?.message
				console.error e[0].message
			else
				console.error.toString()

D=(str)=>
	E "#{AppName}:"+str if ctx.isDebugMode

ctx=
	isDebugMode:false
	command:'normal'
	width:20


optUsages=
	h:"ヘルプ"
	d:"デバッグモード"
	w:["文字数","折り返す文字数"]


try
	GetOpt.setopt 'h?dw:'
catch e
	switch e.type
		when 'unknown'
			E "Unknown option:#{e.opt}"
		when 'required'
			E "Required parameter for option:#{e.opt}"
	process.exit(1)

GetOpt.getopt (o,p)->
	switch o
		when 'h','?'
			ctx.command='usage'
		when 'd'
			ctx.isDebugMode=true
		when 'w'
			ctx.width=Number p[0]

try
	D "==starting #{AppName}"
	D "-options"
	D JSON.stringify ctx
	D "-------"
	D "sanity checking.."
	D "..OK"
catch e
	E e.toString()
	process.exit 1

try
	switch ctx.command
		when 'usage'
			P """
			## コマンドライン
			
		    jfold [-w <文字数> ] 

			## オプション

	        -h ヘルプ
	        -d デバッグモード
	        -w: <文字数> 折り返す文字数(例 -w 30)
			"""
		when 'normal'
			B=($G,$_)=>
				$G.f=ctx.width*2
			NE=($G,$_)=>
				b=$_.split ''
				i=0
				while(c=b.shift())
					O c
					i++
					unless c.match /[\x20-\x7E]/
						i++
					if (i>=$G.f-1 and !(b?[0]?.match(/[,\)\]）｝、〕〉》」』】〙〗〟ゝゞーァィゥェォッャュョヮヵヶぁぃぅぇぉっゃゅょゎゕゖ‐゠–〜～\?!‼⁇⁈⁉・:;\/ㇰㇱㇲㇳㇴㇵㇶㇷㇸㇹㇷ゚ㇺㇻㇼㇽㇾㇿ々〻’”｠»。.]/))) or (b?[0]?.match(/[（\([｛〔〈《「『【〘〖〝‘“｟«]/) and i>=($G.f-3))
						D i
						O "\n"
						i=0
					else if b.length == 0
						D i
						O "\n"

			Norl.ne NE,B
catch e
	E e

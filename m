Message-ID: <4F72D60D.30405@...1147...>
Date: Wed, 28 Mar 2012 11:12:45 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20120326160546.GV1359@...1296...>	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...>
In-Reply-To: <20120326175543.GX1359@...1296...>
Content-Type: multipart/alternative;
	boundary="------------050503090205090707090608"
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
 now
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

This is a multi-part message in MIME format.
--------------050503090205090707090608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Gert Doering wrote:
> Hi,
>
> On Mon, Mar 26, 2012 at 07:51:01PM +0200, Alon Bar-Lev wrote:
>   
>> The benefit is to divide the code into libraries and core which is
>> easier to maintain and reuse.
>>     
>
> I'm not sure I understand what's so hard about "compile stuff, use
> 'ar' to pack into libopenvpn.a" that stuff needs more convolutions.
>
> We're not building a shared library - which I agree is major pains unless
> handled by libtool.  But static libraries are easy on about everything
> (except Windows, can't speak about that).
>
>   
actually, most of the problems I've seen with libtool have to deal with 
shared libraries - I would NOT trust libtool to be able to build shared 
libraries the way I want it to, esp when shared libs use other shared 
libs. don't know if libtool 2.x solves the issues found in 1.5
>> Anyway, new automake does support silent rules, try the following[1]
>> patch and see if it makes you happier.
>>     
>
> This is missing the point: I think what automake/autoconf is doing now
> is much too complicated.  I *like* to see what it's doing, and hiding
> complexity by just not showing it is a step into the wrong direction.
>
>   
I fully agree with Gert here; if we can avoid libtool then I'd really 
like to do so - it only adds an extra layer that (IMHO) is not needed; 
what was wrong with the "old" method?

JM2CW,

JJK


--------------050503090205090707090608
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
Gert Doering wrote:
<blockquote cite="mid:20120326175543.GX1359@...1296..." type="cite">
  <pre wrap="">Hi,

On Mon, Mar 26, 2012 at 07:51:01PM +0200, Alon Bar-Lev wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">The benefit is to divide the code into libraries and core which is
easier to maintain and reuse.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm not sure I understand what's so hard about "compile stuff, use
'ar' to pack into libopenvpn.a" that stuff needs more convolutions.

We're not building a shared library - which I agree is major pains unless
handled by libtool.  But static libraries are easy on about everything
(except Windows, can't speak about that).

  </pre>
</blockquote>
actually, most of the problems I've seen with libtool have to deal with
shared libraries - I would NOT trust libtool to be able to build shared
libraries the way I want it to, esp when shared libs use other shared
libs. don't know if libtool 2.x solves the issues found in 1.5<br>
<blockquote cite="mid:20120326175543.GX1359@...1296..." type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">Anyway, new automake does support silent rules, try the following[1]
patch and see if it makes you happier.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is missing the point: I think what automake/autoconf is doing now
is much too complicated.  I *like* to see what it's doing, and hiding
complexity by just not showing it is a step into the wrong direction.

  </pre>
</blockquote>
I fully agree with Gert here; if we can avoid libtool then I'd really
like to do so - it only adds an extra layer that (IMHO) is not needed;
what was wrong with the "old" method?<br>
<br>
JM2CW,<br>
<br>
JJK<br>
<br>
</body>
</html>

--------------050503090205090707090608--


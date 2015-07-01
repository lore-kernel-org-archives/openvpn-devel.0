Message-ID: <5594457B.9000100@...1227...>
Date: Wed, 01 Jul 2015 21:54:35 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <015601d0b436$d555ad60$80010820$@gmail.com>
In-Reply-To: <015601d0b436$d555ad60$80010820$@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------050405010508020401080805"
Subject: Re: [Openvpn-devel] Compiling issue on Visual Studio 2010
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050405010508020401080805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.07.15 um 21:47 schrieb Fish Wang:
>
> Hi,
>
>  
>
> Visual Studio 2010 refuses to compile the latest code on branch
> release/2.3 because __func__ is not supported. Microsoft supports
> __FUNCTION__ instead of __func__ in their compiler. VS 2013 complains
> the same.
>
>  
>
> The following patch resolves this issue.
>
>  
>
I would prefer to define _func_ as __FUNCTION__ for 2010 to keep the
standard notion and not introduce yet another macro.

Arne

--------------050405010508020401080805
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 01.07.15 um 21:47 schrieb Fish Wang:<br>
    </div>
    <blockquote cite="mid:015601d0b436$d555ad60$80010820$@gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US">Hi,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Visual Studio 2010
            refuses to compile the latest code on branch release/2.3
            because __func__ is not supported. Microsoft supports
            __FUNCTION__ instead of __func__ in their compiler. VS 2013
            complains the same.<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">The following patch
            resolves this issue.<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span><br>
        </p>
      </div>
    </blockquote>
    I would prefer to define _func_ as __FUNCTION__ for 2010 to keep the
    standard notion and not introduce yet another macro.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------050405010508020401080805--


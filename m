Message-ID: <4E2E3AC5.2030005@...1299...>
Date: Tue, 26 Jul 2011 15:55:49 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <1311649077083710500@...1315...>
In-Reply-To: <1311649077083710500@...1315...>
Content-Type: multipart/alternative;
	boundary="------------000409090800040201000002"
Subject: Re: [Openvpn-devel] Windows Auto-Proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000409090800040201000002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 26/07/11 14:57, Russell Morris wrote:
>
> I use OpenVPN with a Windows client, and I tend to be on one network
> one minute, another the next. One time with a proxy, the next time
> without ... so I really want OpenVPN to automatically detect the proxy
> (if there is one), and apply it ... for every connection restart,
> client open, etc. My thinking is to add a new option, say something
> like "auto-proxy" (so this won't break anything that is already
> working!). The idea being that if this option is enabled, then on
> every connection / reconnection attempt OpenVPN will first check the
> proxy, and then apply it for the actual connection back to the server.
> Hopefully this makes sense so far ... J.
>

...isn't that already done by "--auto-proxy"? Been part of openvpn since
2.1(ish?)

BTW: I totally agree this is a big deal. For openvpn to be truly
brilliant, it needs

1. one config to handle both udp and tcp-based "<connection>" profiles
[sorta supported]
2. "fragment", "mss-fix" and proxy support within profiles  [not
currently supported - which effectively makes "1." never work in practice]
3. dynamically figure out if a proxy is available and use that for
TCP-based profiles [I thought that was supported by "--auto-proxy"]

With such features and a properly ordered config, you'd have a VPN
client that would tunnel out over UDP if it can, TCP if it can't, and
TCP-via-proxy if it has to. Basically, you'd be guaranteed a working VPN
session on any network that you're meant to be able to do such things on
(with one config).


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


--------------000409090800040201000002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 26/07/11 14:57, Russell Morris wrote:
    <blockquote cite="mid:1311649077083710500@...1315..." type="cite">
      <style id="axi-htmleditor-style" type="text/css">p { margin: 0px; }</style><br>
      <div style="">
        <meta content="text/html; charset=us-ascii" equiv="Content-Type"
          http="HTTP">
        <meta name="ProgId" content="Word.Document">
        <meta name="Generator" content="Microsoft Word 12">
        <meta name="Originator" content="Microsoft Word 12">
        <link rel="File-List">
        <link rel="themeData" href="%7E%7Ethemedata%7E%7E">
        <link rel="colorSchemeMapping"
          href="%7E%7Ecolorschememapping%7E%7E">
        <style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-alt:Wingdings;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Arial Rounded MT Bold";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	mso-themecolor:hyperlink;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></style>
        <div class="WordSection1">
          <p class="MsoNormal">I use OpenVPN with a Windows client, and
            I tend to be on one network one minute, another the next.
            One time with a proxy, the next time without &#8230; so I really
            want OpenVPN to automatically detect the proxy (if there is
            one), and apply it &#8230; for every connection restart, client
            open, etc. My thinking is to add a new option, say something
            like &#8220;auto-proxy&#8221; (so this won&#8217;t break anything that is
            already working!). The idea being that if this option is
            enabled, then on every connection / reconnection attempt
            OpenVPN will first check the proxy, and then apply it for
            the actual connection back to the server. Hopefully this
            makes sense so far &#8230; <span style="FONT-FAMILY: Wingdings;
              mso-ascii-font-family: Calibri; mso-ascii-theme-font:
              minor-latin; mso-hansi-font-family: Calibri;
              mso-hansi-theme-font: minor-latin; mso-char-type: symbol;
              mso-symbol-font-family: Wingdings"><span
                style="mso-char-type: symbol; mso-symbol-font-family:
                Wingdings">J</span></span>.</p>
        </div>
      </div>
    </blockquote>
    <br>
    ...isn't that already done by "--auto-proxy"? Been part of openvpn
    since 2.1(ish?)<br>
    <br>
    BTW: I totally agree this is a big deal. For openvpn to be truly
    brilliant, it needs<br>
    <br>
    1. one config to handle both udp and tcp-based "&lt;connection&gt;"
    profiles [sorta supported]<br>
    2. "fragment", "mss-fix" and proxy support within profiles&nbsp; [not
    currently supported - which effectively makes "1." never work in
    practice]<br>
    3. dynamically figure out if a proxy is available and use that for
    TCP-based profiles [I thought that was supported by "--auto-proxy"]<br>
    <br>
    With such features and a properly ordered config, you'd have a VPN
    client that would tunnel out over UDP if it can, TCP if it can't,
    and TCP-via-proxy if it has to. Basically, you'd be guaranteed a
    working VPN session on any network that you're meant to be able to
    do such things on (with one config).<br>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1
</pre>
  </body>
</html>

--------------000409090800040201000002--


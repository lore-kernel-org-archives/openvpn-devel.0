MIME-Version: 1.0
Message-ID: <trinity-c9f34b33-ad86-499b-a896-dd75d4d61e86-1379323790592@...1840...>
From: Max.Muster@...1832...
Date: Mon, 16 Sep 2013 11:29:50 +0200 (CEST)
In-Reply-To: <l142b7$15v$1@...1062...>
References: <l142b7$15v$1@...1062...>
Subject: Re: [Openvpn-devel] [PATCH] Fix file access checks when using
 --chroot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>Did not look into the patch in detail, but it should fix bug #299, too.</div>

<div>&nbsp;</div>

<div>Hopfully this will get some more response than my approach there ;-)</div>

<div>&nbsp;</div>

<div>Regards</div>

<div>&nbsp;</div>

<div>Joerg</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;
<div name="quote" style="margin:10px 5px 5px 10px; padding: 10px 0 10px 10px; border-left:2px solid #C3D9E5; word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">
<div style="margin:0 0 10px 0;"><b>Gesendet:</b>&nbsp;Sonntag, 15. September 2013 um 11:42 Uhr<br/>
<b>Von:</b>&nbsp;&quot;Josh Cepek&quot; &lt;josh.cepek@...1085...&gt;<br/>
<b>An:</b>&nbsp;openvpn-devel@lists.sourceforge.net<br/>
<b>Betreff:</b>&nbsp;[Openvpn-devel] [PATCH] Fix file access checks when using --chroot</div>

<div name="quoted-content">-----BEGIN PGP SIGNED MESSAGE-----<br/>
Hash: SHA1<br/>
<br/>
The attached patch fixes bug #330 which causes a regression from 2.2.x<br/>
where valid configs won&#39;t work in certain cases when using --chroot. A<br/>
more terse overview of the change is presented in the patch itself.<br/>
<br/>
The additional error checking for files &amp; scripts introduced for 2.3<br/>
don&#39;t take into account that the file path changes after the chroot<br/>
operation, preventing options_postprocess_filechecks() from checking the<br/>
proper paths.<br/>
<br/>
The changes in this patch intelligently look at the pre-chroot path when<br/>
required by appending the &quot;in-chroot&quot; path after the specified chroot<br/>
dir. To bring in support for dynamic string/memory management and the<br/>
ability to see if chroot is used, some callers were also modified to<br/>
pass in pointers to the options struct. Additionally, some bitmask<br/>
#defines were included even with ENABLE_SMALL as the set_user_script()<br/>
callers in option_add() need the ability to define if the script in<br/>
question is accessed from within the chroot or not so the access checks<br/>
can be made properly.<br/>
<br/>
Besides the low-impact #define changes, all the impacted code is not<br/>
built with ENABLE_SMALL, so this shouldn&#39;t be a problem for embedded<br/>
systems. I also tried to be helpful with the error messages returned<br/>
from check_file_access() by informing users if the failing path is<br/>
pre-chroot since the text won&#39;t match a direct string supplied but a<br/>
combination of two.<br/>
<br/>
On a much smaller note, there seemed to be a mix of indent styles in a<br/>
few places where apparent alignment was made for tabs expanding to 8<br/>
spaces; I have aligned this patch assuming a tab is 2 spaces, leaving<br/>
the issue of whitespace cleanup for a separate patch. All new lines use<br/>
spaces only.<br/>
<br/>
<br/>
- --<br/>
Josh<br/>
-----BEGIN PGP SIGNATURE-----<br/>
Version: GnuPG v2.0.20 (GNU/Linux)<br/>
<br/>
iQGcBAEBAgAGBQJSNYEZAAoJENcx2Xpgb9Rjm6gL/1epNkDRCWMEjb/GGo86ECk4<br/>
092oQNmAS8fssD2y0YULJ7xKT5O6JUq+yCIsxjHMIpBpeRBmn+nwVTP33gPdFNFb<br/>
RYg1eIUb/EL0to56S7tSm+018aW80LH5fp8CyQcpTWHJd5sW1sYwxtLmk1Ho6cAb<br/>
4bKy709sOZfSIvqhBHe342izqFtPWsO0RV16NrFL7vKbr+ubc3hgGiEEB/f+U3n9<br/>
S/kbQXbrcBi5OUsjbulNAgOyR641rS3CcE7pde/dxMVo21OBmDiXkzksHFpugLlv<br/>
xhaa3JqM2KCiJb+x04N7WT9F+h7UPsvyc4P+gyccb/UVPgdE3SR2ERlwv8x2uSqy<br/>
7/sMrGaT9pwfd+P4bywBGvv+16VOeEwhItrX5sy9rGIsx1I0FiXpt7MROU2FERFB<br/>
sk/WRcEchXfB+Z9RSBZwtbeRf0w6dF7nCDOEr1NWTrLYGIX1Z+iZ4jXBzt+0qU3v<br/>
O518OD3QA7apvQqvptDl9ExY3LRu+H6y4WZWeapHwQ==<br/>
=V6Ck<br/>
-----END PGP SIGNATURE-----<br/>
------------------------------------------------------------------------------<br/>
LIMITED TIME SALE - Full Year of Microsoft Training For Just &#36;49.99!<br/>
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint<br/>
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes<br/>
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/22/13.<br/>
<a href="http://pubads.g.doubleclick.net/gampad/clk?id=64545871&amp;iu=/4140/ostg.clktrk_______________________________________________" target="_blank">http://pubads.g.doubleclick.net/gampad/clk?id=64545871&amp;iu=/4140/ostg.clktrk_______________________________________________</a><br/>
Openvpn-devel mailing list<br/>
Openvpn-devel@lists.sourceforge.net<br/>
<a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a></div>
</div>
</div>
</div>

<div>&nbsp;</div>

<div class="signature">&nbsp;</div></div></body></html>


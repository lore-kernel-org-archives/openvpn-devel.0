From: Kristof Provost <kprovost@...2661...>
Date: Fri, 11 Nov 2022 11:48:44 +0100
Message-ID: <4A01005C-D9B0-48A4-9046-E86A4053AB16@...2661...>
In-Reply-To: <41468dc8-c756-aea7-5276-b29e45da9aef@...1227...>
References: <20221111102031.8402-1-kprovost@...2661...>
 <41468dc8-c756-aea7-5276-b29e45da9aef@...1227...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_9B55A8D2-A1FA-4FF3-B6BE-76C6CD173AB3_="
Content-Transfer-Encoding: 8bit
Subject: Re: [Openvpn-devel] [PATCH]: FreeBSD DCO supports AES-192-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=_MailMate_9B55A8D2-A1FA-4FF3-B6BE-76C6CD173AB3_=
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 11 Nov 2022, at 11:36, Arne Schwabe wrote:
> Am 11.11.2022 um 11:20 schrieb Kristof Provost via Openvpn-devel:
>> Minor update, but FreeBSD's if_ovpn now also supports AES-192-GCM.
>> We may as well announce this support.
>>
> This seems to be missing the patch.
>
Git’s send-email sent it as a separate mail, which has turned up with 
a bit of a delay for me.
I’m hoping it’ll actually turn up for you too, but in the mean time:

	From: Kristof Provost <kp@...1376...>

	As of 2c58d0cb3bb3e3a5b714ffac940500efbe5303ca FreeBSD also allows
	AES-192-GCM in DCO. Announce this support.

	Signed-off-by: Kristof Provost <kprovost@...2661...>
	---
	 src/openvpn/dco_freebsd.c | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)

	diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
	index c8361028..8e5ee436 100644
	--- a/src/openvpn/dco_freebsd.c
	+++ b/src/openvpn/dco_freebsd.c
	@@ -667,7 +667,7 @@ dco_event_set(dco_context_t *dco, struct event_set 
*es, void *arg)
	 const char *
	 dco_get_supported_ciphers()
	 {
	-    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
	+    return 
"none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
	 }
	
	 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
	--
	2.38.1


Best regards,
Kristof
--=_MailMate_9B55A8D2-A1FA-4FF3-B6BE-76C6CD173AB3_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" style=
=3D"white-space: normal;">
<p dir=3D"auto">On 11 Nov 2022, at 11:36, Arne Schwabe wrote:</p>
</div><div class=3D"plaintext" style=3D"white-space: normal;"><blockquote s=
tyle=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE;=
 color: #136BCE;"><p dir=3D"auto">Am 11.11.2022 um 11:20 schrieb Kristof Pr=
ovost via Openvpn-devel:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px s=
olid #136BCE; border-left-color: #4B89CF; color: #4B89CF;"><p dir=3D"auto">=
Minor update, but FreeBSD's if_ovpn now also supports AES-192-GCM.
<br>
We may as well announce this support.</p>
</blockquote><p dir=3D"auto">This seems to be missing the patch.</p>
<br></blockquote></div>
<div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">Git=E2=80=99s send-email sent it as a separate mail, which =
has turned up with a bit of a delay for me.<br>
I=E2=80=99m hoping it=E2=80=99ll actually turn up for you too, but in the m=
ean time:</p>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; border: =
thin solid gray; overflow-x: auto; max-width: 90vw; background-color: #E4E4=
E4;"><code style=3D"padding: 0 0.25em; background-color: #E4E4E4;">From: Kr=
istof Provost &lt;kp@...1376...&gt;

As of 2c58d0cb3bb3e3a5b714ffac940500efbe5303ca FreeBSD also allows
AES-192-GCM in DCO. Announce this support.

Signed-off-by: Kristof Provost &lt;kprovost@...2661...&gt;
---
 src/openvpn/dco_freebsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index c8361028..8e5ee436 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -667,7 +667,7 @@ dco_event_set(dco_context_t *dco, struct event_set *es,=
 void *arg)
 const char *
 dco_get_supported_ciphers()
 {
-    return &quot;none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;
+    return &quot;none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY130=
5&quot;;
 }

 #endif /* defined(ENABLE_DCO) &amp;&amp; defined(TARGET_FREEBSD) */
--
2.38.1
</code></pre>
<p dir=3D"auto">Best regards,<br>
Kristof</p>

</div>
</div>
</body>

</html>

--=_MailMate_9B55A8D2-A1FA-4FF3-B6BE-76C6CD173AB3_=--


Date: Wed, 22 Jan 2014 09:27:29 +0100
From: Thomas Veerman <thomas.veerman@...1862...>
Message-ID: <etPan.52df80ec.2901d82.13bb7@...1863...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="52df80f1_8138641_13bb7"
Subject: [Openvpn-devel] [PATCH] Update expiry date in management event loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--52df80f1_8138641_13bb7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When there are events from the management console with an interval shorter
than 1 second, the event loop never stops as it keeps resetting event_wait.
---
=C2=A0src/openvpn/manage.c | 3 ++-
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 22dbe13..42a87c2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2922,7 +2922,8 @@ management_event_loop_n_seconds (struct management *m=
an, int sec)
=C2=A0	 =C2=A0 =C2=A0man_check_for_signals (&signal_received);
=C2=A0	 =C2=A0if (signal_received)
=C2=A0	 =C2=A0 =C2=A0return;
-	} while (expire);
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_time();
+	} while (expire && expire > now);
=C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* revert state */
=C2=A0 =C2=A0 =C2=A0 =C2=A0man->persist.standalone_disabled =3D standalone_=
disabled_save;
--=C2=A0
1.7.12.4 (Apple Git-37)


--52df80f1_8138641_13bb7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style>body{font-family:Helvetica,Arial;font-size:13px}</style>=
</head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -web=
kit-line-break: after-white-space; "><div id=3D"bloop_customfont" style=3D"=
font-family:Helvetica,Arial;font-size:13px; color: rgba(0,0,0,1.0); margin:=
 0px; line-height: auto;"><div id=3D"bloop_customfont" style=3D"margin: 0px=
; ">When there are events from the management console with an interval shor=
ter</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">than 1 second=
, the event loop never stops as it keeps resetting event_wait.</div><div id=
=3D"bloop_customfont" style=3D"margin: 0px; ">---</div><div id=3D"bloop_cus=
tomfont" style=3D"margin: 0px; ">&nbsp;src/openvpn/manage.c | 3 ++-</div><d=
iv id=3D"bloop_customfont" style=3D"margin: 0px; ">&nbsp;1 file changed, 2 =
insertions(+), 1 deletion(-)</div><div id=3D"bloop_customfont" style=3D"mar=
gin: 0px; "><br></div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">=
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</div><div id=3D"bl=
oop_customfont" style=3D"margin: 0px; ">index 22dbe13..42a87c2 100644</div>=
<div id=3D"bloop_customfont" style=3D"margin: 0px; ">--- a/src/openvpn/mana=
ge.c</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">+++ b/src/op=
envpn/manage.c</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">@@=
 -2922,7 +2922,8 @@ management_event_loop_n_seconds (struct management *man=
, int sec)</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">&nbsp;=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> &nbsp; &n=
bsp;man_check_for_signals (&amp;signal_received);</div><div id=3D"bloop_cus=
tomfont" style=3D"margin: 0px; ">&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span> &nbsp;if (signal_received)</div><div id=3D"bl=
oop_customfont" style=3D"margin: 0px; ">&nbsp;<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span> &nbsp; &nbsp;return;</div><div id=3D"b=
loop_customfont" style=3D"margin: 0px; ">-<span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>} while (expire);</div><div id=3D"bloop_cus=
tomfont" style=3D"margin: 0px; ">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;update=
_time();</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">+<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>} while (expire &=
amp;&amp; expire &gt; now);</div><div id=3D"bloop_customfont" style=3D"marg=
in: 0px; ">&nbsp;</div><div id=3D"bloop_customfont" style=3D"margin: 0px; "=
>&nbsp; &nbsp; &nbsp; &nbsp;/* revert state */</div><div id=3D"bloop_custom=
font" style=3D"margin: 0px; ">&nbsp; &nbsp; &nbsp; &nbsp;man-&gt;persist.st=
andalone_disabled =3D standalone_disabled_save;</div><div id=3D"bloop_custo=
mfont" style=3D"margin: 0px; ">--&nbsp;</div><div id=3D"bloop_customfont" s=
tyle=3D"margin: 0px; ">1.7.12.4 (Apple Git-37)</div><div id=3D"bloop_custom=
font" style=3D"margin: 0px; "><br></div></div></body></html>=

--52df80f1_8138641_13bb7--



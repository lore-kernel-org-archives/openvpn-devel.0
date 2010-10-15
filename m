Date: Fri, 15 Oct 2010 15:53:06 +0200
Message-Id: <LAC3WI$592D614BC26C7E00D314E375A9E2267B@...1417...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_=__=_XaM3_.1287150786.2A.382330.42.5560.52.42.007.1596218869"
From: "openvpn" <openvpn@...1416...>
Subject: Re: [Openvpn-devel] openvpn, NTLM and McAfee Web Gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--_=__=_XaM3_.1287150786.2A.382330.42.5560.52.42.007.1596218869
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> I read your blog post, interesting stuff. The strings the client sends
> seem to be base64 encoded and the first part on both messages look like
> this (in nano/vi):
>=20
> NTLMSSP
>=20
> It's followed by this, which is apparently the message type hex string:
>=20
> ^@^A^@^@^@
>=20
> After this they differ noticeably. I'd guess they are just sending
> different NTLM flags:
>=20
>=20
>=20
> Can somebody more fluent in NTLM protocol decipher these two messages?
>=20
> --=20
> Samuli Sepp?nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
=C2=A0=C2=A0
Firefox uses the following flags:
=C2=A0
#define NTLM_TYPE1_FLAGS      \
(NTLM_NegotiateUnicode |    \
NTLM_NegotiateOEM |        \
NTLM_RequestTarget |       \
NTLM_NegotiateNTLMKey |    \
NTLM_NegotiateAlwaysSign | \
NTLM_NegotiateNTLM2Key)

=C2=A0
take a look here for more informations:=20
=C2=A0
http://hg.mozilla.org/releases/mozilla-1.9.2/file/d1c0b2c4ac7a/security/man=
ager/ssl/src/nsNTLMAuthModule.cppI hope that's may helps.
=C2=A0
vittorio

--_=__=_XaM3_.1287150786.2A.382330.42.5560.52.42.007.1596218869
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


<div class=3D"xam_msg_class">
<div style=3D"font: normal 13px Arial; color:rgb(0, 0, 0);"><div><div>&gt; =
Hi,</div><div>&gt; </div><div>&gt; I read your blog post, interesting stuff=
. The strings the client sends</div><div>&gt; seem to be base64 encoded and=
 the first part on both messages look like</div><div>&gt; this (in nano/vi)=
:</div><div>&gt; </div><div>&gt; NTLMSSP</div><div>&gt; </div><div>&gt; It'=
s followed by this, which is apparently the message type hex string:</div><=
div>&gt; </div><div>&gt; ^@^A^@^@^@</div><div>&gt; </div><div>&gt; After th=
is they differ noticeably. I'd guess they are just sending</div><div>&gt; d=
ifferent NTLM flags:</div><div>&gt; </div><div>&gt; </div><div>&gt; </div><=
div>&gt; Can somebody more fluent in NTLM protocol decipher these two messa=
ges?</div><div>&gt; </div><div>&gt; -- </div><div>&gt; Samuli Sepp?nen</div=
><div>&gt; Community Manager</div><div>&gt; OpenVPN Technologies, Inc</div>=
<div>&gt; </div><div>&gt; irc freenode net: mattock</div><div>&gt; </div><d=
iv>&nbsp;</div>&nbsp;</div><div>Firefox uses the following flags:</div><div=
>&nbsp;</div><div><div style=3D"font-family: monospace;" class=3D"parity0">=
<pre>#define NTLM_TYPE1_FLAGS      \
(NTLM_NegotiateUnicode |    \
NTLM_NegotiateOEM |        \
NTLM_RequestTarget |       \
NTLM_NegotiateNTLMKey |    \
NTLM_NegotiateAlwaysSign | \
NTLM_NegotiateNTLM2Key)
</pre></div></div><div>&nbsp;</div><div>take a look here for more informati=
ons: </div><div>&nbsp;</div><div>http://hg.mozilla.org/releases/mozilla-1.9=
.2/file/d1c0b2c4ac7a/security/manager/ssl/src/nsNTLMAuthModule.cpp<br><br>I=
 hope that's may helps.</div><div>&nbsp;</div><div>vittorio <br></div><br><=
/div>
</div>


--_=__=_XaM3_.1287150786.2A.382330.42.5560.52.42.007.1596218869--



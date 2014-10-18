MIME-Version: 1.0
In-Reply-To: <9453768.108293.1413591263095.JavaMail.root@...1893...>
References: <13177950.74478.1413544590694.JavaMail.root@...1893...>
	<54411BA1.9080402@...1227...>
	<17844314.87425.1413555693684.JavaMail.root@...1893...>
	<CAFHpkQFXzF6D3X8DYHHLzb+gpvYDcVoHR8JKGG1p+o4w_GtFVw@...278...>
	<9453768.108293.1413591263095.JavaMail.root@...1893...>
Date: Sat, 18 Oct 2014 09:40:33 +0600
Message-ID: <CAFHpkQGH3pk1FyLB5bHLPkVQjfwsMhyXyrttJZG_=au5J_Hbpg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=047d7b418c2d6a477b0505aa3e33
Subject: Re: [Openvpn-devel] New OpenVPN bundles for Windows platform that
 incorporate OpenSSL 1.0.1j
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b418c2d6a477b0505aa3e33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

how does that affect OpenVPN?

=D1=81=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0, 18 =D0=BE=D0=BA=D1=82=D1=8F=D0=
=B1=D1=80=D1=8F 2014 =D0=B3. =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=
=B0=D1=82=D0=B5=D0=BB=D1=8C Lisa Minogue =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:

> OpenSSL Security Advisory [15 Oct 2014]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> SRTP Memory Leak (CVE-2014-3513)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> Severity: High
>
> A flaw in the DTLS SRTP extension parsing code allows an attacker, who
> sends a carefully crafted handshake message, to cause OpenSSL to fail
> to free up to 64k of memory causing a memory leak. This could be
> exploited in a Denial Of Service attack. This issue affects OpenSSL
> 1.0.1 server implementations for both SSL/TLS and DTLS regardless of
> whether SRTP is used or configured. Implementations of OpenSSL that
> have been compiled with OPENSSL_NO_SRTP defined are not affected.
>
> OpenSSL 1.0.1 users should upgrade to 1.0.1j.
>
> This issue was reported to OpenSSL on 26th September 2014, based on an
> original
> issue and patch developed by the LibreSSL project. Further analysis of the
> issue
> was performed by the OpenSSL team.
>
> The fix was developed by the OpenSSL team.
>
>
> Session Ticket Memory Leak (CVE-2014-3567)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Severity: Medium
>
> When an OpenSSL SSL/TLS/DTLS server receives a session ticket the
> integrity of that ticket is first verified. In the event of a session
> ticket integrity check failing, OpenSSL will fail to free memory
> causing a memory leak. By sending a large number of invalid session
> tickets an attacker could exploit this issue in a Denial Of Service
> attack.
>
> OpenSSL 1.0.1 users should upgrade to 1.0.1j.
> OpenSSL 1.0.0 users should upgrade to 1.0.0o.
> OpenSSL 0.9.8 users should upgrade to 0.9.8zc.
>
> This issue was reported to OpenSSL on 8th October 2014.
>
> The fix was developed by Stephen Henson of the OpenSSL core team.
>
>
> SSL 3.0 Fallback protection
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> Severity: Medium
>
> OpenSSL has added support for TLS_FALLBACK_SCSV to allow applications
> to block the ability for a MITM attacker to force a protocol
> downgrade.
>
> Some client applications (such as browsers) will reconnect using a
> downgraded protocol to work around interoperability bugs in older
> servers. This could be exploited by an active man-in-the-middle to
> downgrade connections to SSL 3.0 even if both sides of the connection
> support higher protocols. SSL 3.0 contains a number of weaknesses
> including POODLE (CVE-2014-3566).
>
> OpenSSL 1.0.1 users should upgrade to 1.0.1j.
> OpenSSL 1.0.0 users should upgrade to 1.0.0o.
> OpenSSL 0.9.8 users should upgrade to 0.9.8zc.
>
> https://tools.ietf.org/html/draft-ietf-tls-downgrade-scsv-00
> https://www.openssl.org/~bodo/ssl-poodle.pdf
>
> Support for TLS_FALLBACK_SCSV was developed by Adam Langley and Bodo
> Moeller.
>
>
> Build option no-ssl3 is incomplete (CVE-2014-3568)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> Severity: Low
>
> When OpenSSL is configured with "no-ssl3" as a build option, servers
> could accept and complete a SSL 3.0 handshake, and clients could be
> configured to send them.
>
> OpenSSL 1.0.1 users should upgrade to 1.0.1j.
> OpenSSL 1.0.0 users should upgrade to 1.0.0o.
> OpenSSL 0.9.8 users should upgrade to 0.9.8zc.
>
> This issue was reported to OpenSSL by Akamai Technologies on 14th October
> 2014.
>
> The fix was developed by Akamai and the OpenSSL team.
>
>
> > ----------------------------------------
> > From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD <chipitsine@...277... <javascript:;>>
> > Sent: Fri Oct 17 21:59:04 CEST 2014
> > To: Lisa Minogue <lminogue@...1892... <javascript:;>>
> > Subject: Re: [Openvpn-devel] New OpenVPN bundles for Windows platform
> that incorporate OpenSSL 1.0.1j
> >
> >
> > can you please describe carefully, how those vulnerabilities do affect
> OpenVPN ?
> -----------------------------------------------------
> Mail.be, WebMail and Virtual Office
> http://www.mail.be
>

--047d7b418c2d6a477b0505aa3e33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

how does that affect OpenVPN?<br><br>=D1=81=D1=83=D0=B1=D0=B1=D0=BE=D1=82=
=D0=B0, 18 =D0=BE=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8F 2014 =D0=B3. =D0=BF=
=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C Lisa Min=
ogue  =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">OpenSSL Security Advisory [15 Oct 2014]<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
SRTP Memory Leak (CVE-2014-3513)<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Severity: High<br>
<br>
A flaw in the DTLS SRTP extension parsing code allows an attacker, who<br>
sends a carefully crafted handshake message, to cause OpenSSL to fail<br>
to free up to 64k of memory causing a memory leak. This could be<br>
exploited in a Denial Of Service attack. This issue affects OpenSSL<br>
1.0.1 server implementations for both SSL/TLS and DTLS regardless of<br>
whether SRTP is used or configured. Implementations of OpenSSL that<br>
have been compiled with OPENSSL_NO_SRTP defined are not affected.<br>
<br>
OpenSSL 1.0.1 users should upgrade to 1.0.1j.<br>
<br>
This issue was reported to OpenSSL on 26th September 2014, based on an orig=
inal<br>
issue and patch developed by the LibreSSL project. Further analysis of the =
issue<br>
was performed by the OpenSSL team.<br>
<br>
The fix was developed by the OpenSSL team.<br>
<br>
<br>
Session Ticket Memory Leak (CVE-2014-3567)<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Severity: Medium<br>
<br>
When an OpenSSL SSL/TLS/DTLS server receives a session ticket the<br>
integrity of that ticket is first verified. In the event of a session<br>
ticket integrity check failing, OpenSSL will fail to free memory<br>
causing a memory leak. By sending a large number of invalid session<br>
tickets an attacker could exploit this issue in a Denial Of Service<br>
attack.<br>
<br>
OpenSSL 1.0.1 users should upgrade to 1.0.1j.<br>
OpenSSL 1.0.0 users should upgrade to 1.0.0o.<br>
OpenSSL 0.9.8 users should upgrade to 0.9.8zc.<br>
<br>
This issue was reported to OpenSSL on 8th October 2014.<br>
<br>
The fix was developed by Stephen Henson of the OpenSSL core team.<br>
<br>
<br>
SSL 3.0 Fallback protection<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
<br>
Severity: Medium<br>
<br>
OpenSSL has added support for TLS_FALLBACK_SCSV to allow applications<br>
to block the ability for a MITM attacker to force a protocol<br>
downgrade.<br>
<br>
Some client applications (such as browsers) will reconnect using a<br>
downgraded protocol to work around interoperability bugs in older<br>
servers. This could be exploited by an active man-in-the-middle to<br>
downgrade connections to SSL 3.0 even if both sides of the connection<br>
support higher protocols. SSL 3.0 contains a number of weaknesses<br>
including POODLE (CVE-2014-3566).<br>
<br>
OpenSSL 1.0.1 users should upgrade to 1.0.1j.<br>
OpenSSL 1.0.0 users should upgrade to 1.0.0o.<br>
OpenSSL 0.9.8 users should upgrade to 0.9.8zc.<br>
<br>
<a href=3D"https://tools.ietf.org/html/draft-ietf-tls-downgrade-scsv-00" ta=
rget=3D"_blank">https://tools.ietf.org/html/draft-ietf-tls-downgrade-scsv-0=
0</a><br>
<a href=3D"https://www.openssl.org/~bodo/ssl-poodle.pdf" target=3D"_blank">=
https://www.openssl.org/~bodo/ssl-poodle.pdf</a><br>
<br>
Support for TLS_FALLBACK_SCSV was developed by Adam Langley and Bodo Moelle=
r.<br>
<br>
<br>
Build option no-ssl3 is incomplete (CVE-2014-3568)<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
<br>
Severity: Low<br>
<br>
When OpenSSL is configured with &quot;no-ssl3&quot; as a build option, serv=
ers<br>
could accept and complete a SSL 3.0 handshake, and clients could be<br>
configured to send them.<br>
<br>
OpenSSL 1.0.1 users should upgrade to 1.0.1j.<br>
OpenSSL 1.0.0 users should upgrade to 1.0.0o.<br>
OpenSSL 0.9.8 users should upgrade to 0.9.8zc.<br>
<br>
This issue was reported to OpenSSL by Akamai Technologies on 14th October 2=
014.<br>
<br>
The fix was developed by Akamai and the OpenSSL team.<br>
<br>
<br>
&gt; ----------------------------------------<br>
&gt; From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD &lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;=
chipitsine@...277...&#39;)">chipitsine@...277...</a>&gt;<br>
&gt; Sent: Fri Oct 17 21:59:04 CEST 2014<br>
&gt; To: Lisa Minogue &lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#3=
9;cvml&#39;, &#39;lminogue@...1892...&#39;)">lminogue@...1892...</a>&gt;<br>
&gt; Subject: Re: [Openvpn-devel] New OpenVPN bundles for Windows platform =
that incorporate OpenSSL 1.0.1j<br>
&gt;<br>
&gt;<br>
&gt; can you please describe carefully, how those vulnerabilities do affect=
 OpenVPN ?<br>
-----------------------------------------------------<br>
Mail.be, WebMail and Virtual Office<br>
<a href=3D"http://www.mail.be" target=3D"_blank">http://www.mail.be</a><br>
</blockquote>

--047d7b418c2d6a477b0505aa3e33--


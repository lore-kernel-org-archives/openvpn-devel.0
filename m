Message-ID: <5433FD92.7020400@...1227...>
Date: Tue, 07 Oct 2014 16:49:54 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAPd-S-PVJzdHKfOhMuJMmUG8kEETKweTW46owhAJa6aS4Ny+Qg@...278...>	<5433CFD5.5060901@...515...>
	<CAPd-S-OgUuuFJwkz0Unmszyi1Vmv2WEgBaG+RCJ-bWXBvfNzxg@...278...>
In-Reply-To: <CAPd-S-OgUuuFJwkz0Unmszyi1Vmv2WEgBaG+RCJ-bWXBvfNzxg@...278...>
Content-Type: multipart/alternative;
	boundary="------------030808050503050009050700"
Subject: Re: [Openvpn-devel] Paid Engagement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sio Poh Tan <fjor72@...277...>, =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030808050503050009050700
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 07.10.14 16:32, schrieb Sio Poh Tan:
> Hi Samuli,
>
> Thanks for your reply. I've checked on the link that you provided.
However, it does not mention whether the Windows Crypto API integration
supports TLS 1.2 implementation. I understand that it does support TLS
1.0 implementation, similar to the OpenVPN community version. If the
OpenVPN Connect client is based on the community version, then I doubt
it supports TLS 1.2 using cryptoapicert as I've tested with the
community version. Please correct me if I'm wrong.
>
> I hope someone will be interested to work on this implementation as my
team is having a tight schedule implementing this for a project.

Probably it uses the management-api and the external-key-management API
of the management interface. My Android client (OpenVPN for Android)
uses that API to work with the Android keystore and does TLS 1.2 just
fine. That OpenVPN Connect can use the MAC Crypto store which OpenVPN
does not support kind of confirms that theory.

For anyone who wants to pick up  this work. This probably only replacing
the api calls which do RSA signing of the SHA1 checksum with an API call
that can do signing of SHA1 + SHA* variants (basicialy signing longer
bitstrings).

Arne

--------------030808050503050009050700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Am 07.10.14 16:32, schrieb Sio Poh Tan:<br>
    <span style="white-space: pre;">&gt; Hi Samuli,<br>
      &gt;<br>
      &gt; Thanks for your reply. I've checked on the link that you
      provided. However, it does not mention whether the Windows Crypto
      API integration supports TLS 1.2 implementation. I understand that
      it does support TLS 1.0 implementation, similar to the OpenVPN
      community version. If the OpenVPN Connect client is based on the
      community version, then I doubt it supports TLS 1.2 using
      cryptoapicert as I've tested with the community version. Please
      correct me if I'm wrong.<br>
      &gt;<br>
      &gt; I hope someone will be interested to work on this
      implementation as my team is having a tight schedule implementing
      this for a project.<br>
    </span><br>
    Probably it uses the management-api and the external-key-management
    API of the management interface. My Android client (OpenVPN for
    Android) uses that API to work with the Android keystore and does
    TLS 1.2 just fine. That OpenVPN Connect can use the MAC Crypto store
    which OpenVPN does not support kind of confirms that theory.<br>
    <br>
    For anyone who wants to pick up&nbsp; this work. This probably only
    replacing the api calls which do RSA signing of the SHA1 checksum
    with an API call that can do signing of SHA1 + SHA* variants
    (basicialy signing longer bitstrings).<br>
    <br>
    Arne<br>
  </body>
</html>

--------------030808050503050009050700--


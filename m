Message-ID: <4D060C34.7050801@...1147...>
Date: Mon, 13 Dec 2010 13:06:12 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4D021744.7010307@...515...>
In-Reply-To: <4D021744.7010307@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (9th Dec 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Samuli, David, list,

Samuli Sepp=E4nen wrote:
> Hi,
>
> Here's the summary of the previous community meeting.
>
> Discussed common's "Use extv3 extensions such as subjectAltName as
> common_name" patch which had not been ACKed:
>
> <http://thread.gmane.org/gmane.network.openvpn.devel/4185>
>
> Common fixed a few minor, stylistic issues with the patch.
>
> In deeper analysis it was noted that this feature, or using an external
> CA for OpenVPN certs in general, may be dangerous. Consider the
> following scenario:
>
> - An external root CA (e.g. Verisign) is used for OpenVPN certificates,
>   with or without an internal sub-CA
> - A certificate field such as subjectAltName contains an email address
>   and is used as common_name in OpenVPN
>
> Even if a sub-CA is included in the certificate signing chain, it's
> likely that OpenVPN/OpenSSL will happily accept certificates signed
> _only_ by the external root CA. So, a malicious person could connect to
> the VPN by having a certificate with a faked email address signed by the
> external CA.
>
> This feature could be implemented more safely as a separate plugin using
> the new v3 plug-in API, as that will provide full access to the X509
> certificate object in C code. Dazo sent the second version of the v3
> plug-in API to openvpn-devel mailing list today.
>
>=20=20=20

David and I discussed this a little bit last week on IRC ; OpenSSL (and=20
thus, OpenVPN) will accept all certificates signed by *any* of the CAs=20
present in the --ca file (or --capath directory). That's more or less=20
the way OpenSSL is supposed to work - the CA file/directory contains the=20
set of "trust anchors" which are considered valid (self-signed) CA=20
certificates.
Adding , for example, the Verisign public CA cert as a cert to this file=20
or directory is quite dangerous, even without the aforementioned patch:=20
all certs signed by Verisign would pass the validation test!

What some people get confused about is a stacked certificate vs a=20
certificate chain: OpenVPN only supports stacked CA certificates,=20
meaning that any of the certs present in the stacked file are considered=20
trusted.
What some people want is a certificate chain, like some websites use:=20
the website has a server certificate signed by a sub-CA which in turn is=20
signed by Verisign. The webserver sends the entire chain (server cert +=20
sub-CA cert + verisign cert) to the client for verification. That way=20
the client only needs the Verisign cert to trust a particular website=20
(the Verisign CA cert is installed in most browser by default). OpenVPN=20
does not support this at the moment. It would require changing
  SSL_CTX_use_certificate()
to
  SSL_CTX_use_certificate_chain()
to ensure that the entire certificate chain is sent to the remote end=20
(client or server).

In nearly all cases this is not needed, as both client and server can be=20
configured to use the list of sub-CAs that you want to be trusted.=20
Simply do NOT include the root CA (verisign in the example above) and=20
everything should be OK. Also, there does not need to be any=20
relationship between the CA certs listed in the stacked ca.crt file.

cheers,

JJK



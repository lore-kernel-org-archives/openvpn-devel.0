References: <56D8A6C4.5080803@...2070...>
From: ValdikSS <iam@...2070...>
Message-ID: <56DA04EE.8000200@...2070...>
Date: Sat, 5 Mar 2016 00:58:06 +0300
MIME-Version: 1.0
In-Reply-To: <56D8A6C4.5080803@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JWHUWJdEJ62E3cCxO9QEANCfnn9tifBGC"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JWHUWJdEJ62E3cCxO9QEANCfnn9tifBGC
Content-Type: multipart/mixed; boundary="1SJ9wBqRS7gVeH2CAiPuMmk0hHvCi3kbU"
From: ValdikSS <iam@...2070...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <56DA04EE.8000200@...2070...>
Subject: Re: Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...>
In-Reply-To: <56D8A6C4.5080803@...2070...>

--1SJ9wBqRS7gVeH2CAiPuMmk0hHvCi3kbU
Content-Type: multipart/alternative;
	boundary="------------090705000504010103040906"

This is a multi-part message in MIME format.
--------------090705000504010103040906
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have good news and bad news:

Good news:

  * OpenVPN sends all certificates from the server supplied for --server di=
rective (although with a small bug that a certificate which you have privat=
e key for
    must be supplied on the top)
  * OpenVPN Connect for Android can successfully connect to my server with =
a chain


Bad news:

  * OpenVPN 2.3 and master can't connect to this server, with both OpenSSL =
and PolarSSL backends. Maybe if I supply certificates in correct order, cli=
ent would
    work.



On 03/04/2016 12:04 AM, ValdikSS wrote:
> Hello everyone,
>
> I'm trying to leisurely move from an old existing 1024 bit CA to a new 40=
96 bit one without a hassle for a clients.
> From a X.509 perspective it shouldn't be a problem, and I already have ne=
w CA self-signed and cross-signed with old CA, it should work just fine.
>
> While there's no problem authenticating clients from both old and new CA =
using single instance (multiple certificates in --ca are supported, this in=
formation is
> documented), I need to send two certificates from OpenVPN server: server =
certificate, which is signed by new CA, and cross-signed new CA with old CA=
. This way
> it should work for clients either with old or new CA in configuration fil=
es.
>
> I can't manage server to send more than one certificate to the client. It=
 seems that multiple certificates in --cert directive are supported only on=
 client
> side. Am I missing something, is there a way to push multiple certificate=
s from server? If there isn't a way currently, are there any protocol limit=
ations which
> allows only one certificate to be sent?
>
>


--------------090705000504010103040906
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    I have good news and bad news:<br>
    <br>
    Good news:<br>
    <ul>
      <li>OpenVPN sends all certificates from the server supplied for
        --server directive (although with a small bug that a certificate
        which you have private key for must be supplied on the top)</li>
      <li>OpenVPN Connect for Android can successfully connect to my
        server with a chain</li>
    </ul>
    <br>
    Bad news:<br>
    <ul>
      <li>OpenVPN 2.3 and master can't connect to this server, with both
        OpenSSL and PolarSSL backends. Maybe if I supply certificates in
        correct order, client would work. </li>
    </ul>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 03/04/2016 12:04 AM, ValdikSS wrote:<=
br>
    </div>
    <blockquote cite=3D"mid:56D8A6C4.5080803@...2070..." type=3D"cite">
      <pre wrap=3D"">Hello everyone,

I'm trying to leisurely move from an old existing 1024 bit CA to a new 4096=
 bit one without a hassle for a clients.
--------------090705000504010103040906--

--1SJ9wBqRS7gVeH2CAiPuMmk0hHvCi3kbU--

--JWHUWJdEJ62E3cCxO9QEANCfnn9tifBGC--

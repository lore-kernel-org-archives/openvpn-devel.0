References: <20140413152613.GT16637@...1296...>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20140413152613.GT16637@...1296...>
Message-Id: <BB9236F0-66B5-4482-9228-D92F769DBA1D@...1286...>
From: Eric Crist <ecrist@...1286...>
Date: Sun, 13 Apr 2014 11:05:22 -0500
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Love it. Report always=20

> On Apr 13, 2014, at 10:26 AM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
> OpenVPN does not currently report the version of the SSL library it is
> using - which I'm not sure whether it's by design or just because nobody
> ever added it.  Anyway, right now I think we need it, to help future
> cases.
>=20
> There are a few questions that go along with that, which I want to discuss
> here :-)
>=20
> - shall we report compile-time versions as well, or only run-time version?
>=20
>  Like:
>=20
>    OpenSSL compile version=3D'OpenSSL 1.0.1f 6 Jan 2014'
>        library version=3D'OpenSSL 1.0.1g 7 Apr 2014'
>=20
>  (this is on one of my test systems where I discovered an old OpenSSL
>  installation, and upgraded *after* I built the OpenVPN binary)
>=20
>  While I always like seeing numbers, I think the compile-time version is
>  not actually that useful - if the ABI is not compatible, it will break,
>  and if it is, the library version is what is relevant.
>=20
> - how do I get the library version for PolarSSL?
>=20
> - shall we report the library version to the server, e.g. in the form of
>=20
>   IV_SSL=3DOpenSSL 1.0.1f
>   IV_SSL=3DPolarSSL 1.2.8
>=20
>  as a sysadmin on the server side, I'd welcome this ("show me what my
>  users are running").  From a security geek side, I'm not sure whether
>  there is potential for abuse, so "please give me your input"
>=20
> - if we report it, do we want to report it always (as IV_VER) or only
>  if --push-peer-info is set?
>=20
> feedback, please! :-)
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
> -------------------------------------------------------------------------=
-----
> Put Bad Developers to Shame
> Dominate Development with Jenkins Continuous Integration
> Continuously Automate Build, Test & Deployment=20
> Start a new project now. Try Jenkins in the cloud.
> http://p.sf.net/sfu/13600_Cloudbees
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


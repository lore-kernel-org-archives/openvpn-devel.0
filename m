Content-Type: multipart/mixed;
	boundary="Apple-Mail=_4CEF18F5-7A13-4CA2-A877-09B39023DF02"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <5718879E.8050007@...1227...>
Date: Thu, 21 Apr 2016 19:40:28 +0200
Message-Id: <13924F19-0588-4AF2-9C6A-C32B26391B92@...2127...>
References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
	<5718879E.8050007@...1227...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_4CEF18F5-7A13-4CA2-A877-09B39023DF02
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne,

[=E2=80=A6]

>>=20
> The problem with unit tests and existing software is that, if the
> software hasn't been written with testing in mind, it is often hard
> without major refactoring to do the small java style unit tests. Also
> someone has to write these unit tests and free time is currently sparse
> among the OpenVPN developers.

I agree - adding unit tests is difficult, when the project is not designed =
that way. But: Every journey starts with the first step. I am willing to go=
 the first step. I just do not want to be alone after that.

>=20
> A more realistic first step for OpenVPN is a automated testing suite
> that goes beyond what we have at the moment in shell scripts. Setting up
> a mininet for example and automatically cofingure client and server, and
> see if everything works as expected as an example.
>>=20

Now that you mention it: Please find attached my first pre-alpha version of=
 a vagrant based test server for t_client.sh ;-)

It compiles & runs an openvpn server suitable for t_client.sh in a VM.

Comments welcome (the scripts will go into a dedicated folder, as will the =
Vagrant file. I=E2=80=99m in the middle of sketching this out)

- copy the Vagrant file in ./tests
- edit t_client.rc (see the diff of t_client.rc-sample)
- compiling/starting the server: see blow/in the Vagrant file
- start t_client.sh
--Apple-Mail=_4CEF18F5-7A13-4CA2-A877-09B39023DF02--

Message-ID: <4F4CAF83.6090405@...515...>
Date: Tue, 28 Feb 2012 12:42:11 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F466205.5020006@...1030...>
	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>
	<4F4978D2.70706@...1030...>
	<CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>
	<4F4A31E1.2080503@...1030...>
	<CAOazyz1n6Uz3TuSywisO41J=tjNJ94rbq7LUgw5y3b+dR0J8nA@...278...>
	<4F4A4929.6040407@...1030...>
	<CAOazyz1wNQQgxTciUq0uQjfMyDSJqDdpy63LcUpcwXbs3pWsxQ@...278...>
	<4F4A52DB.1040907@...1030...>
	<CAOazyz2SyQjGk9w00KA93tKUyyMMY9iQ3rL=C8X0wpFKFrLZrw@...278...>
	<4F4B584A.30705@...515...> <4F4BA12E.4080707@...1030...>
In-Reply-To: <4F4BA12E.4080707@...1030...>
Subject: Re: [Openvpn-devel] static build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> Mr Dash Four: could you try following the steps Alon gave in his earlier
>> mail to see if it works for you? The buildsystem fetches the
>> dependencies from standard URLs, see "openvpn-build/generic/build.vars".
>>=20=20=20
> Except that they are not "standard", at least not all of them.
> The Alon's version of "openvpn 2.3_alpha1" is very different from=20
> "openvpn 2.3_alpha1" downloaded from the official openvpn git repository=
=20
> using the same tag! If you do not believe me - take a look for yourself.

I hear you. as you probably know, Alon's been working on major overhaul
of the buildsystem, which affects tons of source code files. In these
cases forking the project temporarily into a separate Git repository is
a standard practice. His patches are now being reviewed and merged into
the official Git repository.

That said, I agree the naming is misleading.

> To conclude this, I am very happy that I was finally able to produce=20
> openvpn, which is statically-linked so that I could avoid all bionic=20
> dependencies or depending on any other android-based stuff. Now I can,=20
> hopefully, use this on my android device without further problems,=20
> fingers crossed!

Good to hear you got it working!

Take care,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



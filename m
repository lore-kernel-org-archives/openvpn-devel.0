Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <57455384.2020007@...515...>
Date: Wed, 25 May 2016 19:32:20 +0200
Message-Id: <F7A2C190-9AB4-4527-8570-10F62E86E56E@...2127...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...>
	<5742C2E1.2060407@...515...>
	<53A330A9-AA2C-4545-A854-0EF7A9B79A1C@...2127...>
	<20160523160426.GL53051@...1296...>
	<57455384.2020007@...515...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net


...
>=20
> The buildmaster part is not documented anywhere. I have shared the master=
 config once when someone requested it - there is nothing inherently privat=
e in there, once the passwords are removed. Setting up buildmaster + builds=
laves could definitely be automated, but it would be a rather massive task.

Samuli, could you send me the scripts? I=92d like to have a look. Maybe the=
re is something that can be replicated. This is something I=92d try to add =
to the scripted integration tests (Vagrant) already in the pipeline.

[=85]

>=20
> Could we use Travis CI with a huge combination of operating systems and b=
uild flags? Or does this kind of use go outside its scope? Right now each c=
ommit triggers something like 150 builds on the buildslaves (in total).
>=20

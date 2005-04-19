From: Alberto Gonzalez Iniesta <agi@...64...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
Message-ID: <20050419173728.GA2126@...30...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0504172223570.14131@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Apr 19 10:37:26 2005
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, Apr 17, 2005 at 10:35:36PM -0600, James Yonan wrote:
> I'm happy to announce that OpenVPN 2.0 has been released!

Congratulations James!  (and all those who helped)

> I'm going to sit back now, relax, maybe try to get my server slashdotted,=
=20
> and I'll try not to think too much about OpenVPN 3.0 until the middle of=
=20
> the week :)

Well, since we're close to the middle of the week, I'd like to ask you a
couple of things... :)

- There're some bugs reports I couldn't reproduce:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D278933
and
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D296834

And the second issue I don't know how to handle is this:
- Start openvpn multiple times for a certain configuration.
- After the first one is started, the rest will 'claim' to fail
  (due to port being in use), but they will leave a process running
  (one each).
- Even killing the first (successful) instance, the rest of the
  processes will remain aroundi (doing nothing, I guess.

Is that a desirable behavior?

Thanks,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3


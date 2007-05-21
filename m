Date: Mon, 21 May 2007 07:07:05 +0200
From: sithglan@...162...
Message-ID: <20070521050705.GC19461@...172...>
References: <20070516135709.GE26428@...172...>
	<20070516145917.GC36293@...1026...>
	<20070520231131.GB19461@...172...>
	<9e0cf0bf0705202145r2ea770cbh99e656ce630de45f@...278...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0705202145r2ea770cbh99e656ce630de45f@...278...>
Subject: Re: [Openvpn-devel] Smartcard Authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Markus Friedl <Markus.Friedl@...1027...>, openvpn devel <openvpn-devel@lists.sourceforge.net>, Jochen Kaiser <Jochen.Kaiser@...1025...>, Michael Gernoth <simigern@...172...>

Hello Alon,

> How do you use with OpenSSH?

I am using Debian etch. I typed in

        apt-get source openssh

edited debian/rules and added "--with-opensc=/usr" after that I build
new debian packages using "fakeroot debian/rules binary". I installed
corresponding packages.

Note: It isn't enough to have a private/public key on the card. You also
need a certificate. The certificate can be self signed. It doesn't
matter. If there is _no_ certificate ssh-agent refuses to add it. Don't
ask me why. Markus, can you answer that for me?

For instruction how to create private/public key and a certificate see
my previous e-mail or this website[1].

(thinkpad) [~] ssh-add -D
All identities removed.
(thinkpad) [~] ssh-add -s 0
Enter passphrase for smartcard:
Card added: 0
(thinkpad) [~] ssh-add -l
1024 a6:a0:9e:0c:3f:c5:27:60:79:f2:50:ca:ca:10:3c:97 Private Key (RSA1)
1024 91:07:e6:b1:a4:7f:6f:d0:b7:97:c4:b8:c0:6f:e9:5a Private Key (RSA)

_Here comes the public key. The keypair I use for openvpn. You have to put it
in .ssh/authorized_keys on the other site_

(thinkpad) [~] ssh-keygen -D 0
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCj13kaiKlxgaOj6XsQB0pQe3XNAWZNXb+Nj6kf+aFLyy8sSgpQmooBC3nhkPU4eNLQ+ZHxGSBUtaneqP0C3JtMx5DLrMjg0NojjmDPGOwTl937CAjRnel+hcmVrs55HptujOXA82gj+ViXjBYcPHBqjOHiA7DNUlxiC1SRPTu5FQ==
1024 65537 115053548544716581387034685161862422245654461095131101014844332373749621514179232504573875936357621036091464289506911398194046275185447859017491685242397147667407911709700759158625908774307490096542183425725948386664993491045011923061351158143484497663085429870663258139349906676909077246854338184602606876949
(thinkpad) [~] ssh faui02
Linux faui02 2.6.20.1 #1 SMP Thu Mar 1 03:03:58 CET 2007 i686
          Welcome to the Computer Science CIP-Pool at FAU-Erlangen

      If you have questions or need help, please look at our web-site
      located at: http://wwwcip.informatik.uni-erlangen.de/

      By using this machine, you agree to our Acceptable-Use Policies:
      http://wwwcip.informatik.uni-erlangen.de/pools/rules/
===============================================================================
You have new mail.
Last login: Mon May 21 00:55:03 2007 from thinkpad-wl.glanzmann.de
sithglan has logged on pts/0 from mephisto.informatik.uni-erlangen.de
sirasenn has logged on pts/1 from mephisto.informatik.uni-erlangen.de
simigern has logged on pts/2 from mephisto.informatik.uni-erlangen.de
snalwuer has logged on pts/3 from faui08.informatik.uni-erlangen.de
sithglan has logged on pts/5 from thinkpad-wl.glanzmann.de
hrschulz has logged on pts/12 from mephisto.informatik.uni-erlangen.de
sirrwebe has logged on pts/14 from mephisto.informatik.uni-erlangen.de
(faui02) [~]

> I recommend of using PKCS#11 as well.
> http://alon.barlev.googlepages.com/openssh-pkcs11

Actually from my point of view opensc is cleaner because it doesn't
include using binary modules from aladdin. Also for ssh for example I
need to use a third party patch. opensc support is in openssh for ages
(since 2001).

Btw have to talked to Markus Friedel if your code does it make upstream?

> I don't use OpenSC, but I heard that there is some  kind of option
> that causes PKCS#11 to release the session. Something related to PIN
> caching?

Might be possible. Do you have an specifics or patch that I could try?
Btw. I had a quick glance at the OpenVPN pkcs#11 Code Base and it is
quite impressive at least in the lines of code. How long did it take you
to develop them?

[1] http://lair.fifthhorseman.net/~dkg/egate/

        Thomas


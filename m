From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 20:03:55 +0000
Message-ID: <BL0PR2101MB10584E9CAAA6B7E508971E00AB540@...2440...>
References: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
 <20180725180018.GA55859@...1296...>
 <BL0PR2101MB1058707381F501AFB7FFA9AAAB540@...2440...>
 <20180725181752.GC55859@...1296...>
In-Reply-To: <20180725181752.GC55859@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Alright, I found the SMTP server and sent the patches out again with git se=
nd-email. Let me know how those look.

-----Original Message-----
From: Gert Doering <gert@...1296...>=20
Sent: Wednesday, July 25, 2018 11:18 AM
To: Kevin Kane <kkane@...2393...>
Cc: Gert Doering <gert@...1296...>; openvpn-devel <openvpn-devel@...1439...=
ceforge.net>
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to po=
pulate Windows VPN flyout

Hi,

On Wed, Jul 25, 2018 at 06:08:19PM +0000, Kevin Kane wrote:
> Ugh. Thanks, Outlook. I'd have to use a personal e-mail account to use so=
mething other than Exchange.
>=20
> The other option is for me to add the files to the e-mail as attachments.=
 Is that acceptable, or do you really need the patch text to be in the mess=
age body?

For applying with "git am" and for reviewing with "I can just quote parts o=
f the patch and comment on it", attachments in anything that is not text/pl=
ain format are also not ideal, but we can try that.

We've had a few patches come in recently that were attachment in a signed m=
ail, and neither patchwork nor git could handle these mails in a satisfying=
 way - as in: patchwork did not recognize them as "patch", and "git am" dec=
lared "no patch in there" - so "save patch as individual file, git am, manu=
ally add in-reply-to to the auto- generated "patch applied" reply mail, etc.

It's a bit of try and error what works in a given environment.

(git send-email talking SMTP to Exchange might actually work more nicely th=
an outlook.  Maybe that was just one particularily weird version of Exchang=
e, or "too many virus scanner plugins hooked in", given that this was Sopho=
s...)

gert

--
"If was one thing all people took for granted, was conviction that if you  =
feed honest figures into a computer, honest figures come out. Never doubted=
  it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...


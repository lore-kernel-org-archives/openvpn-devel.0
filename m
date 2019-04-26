MIME-Version: 1.0
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
 <59329176-c948-a816-d128-4601d7720dcd@...2181...>
 <0600680d-4eb6-0790-9990-26a7cdf0b7cc@...1147...>
In-Reply-To: <0600680d-4eb6-0790-9990-26a7cdf0b7cc@...1147...>
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Fri, 26 Apr 2019 16:35:19 +0200
Message-ID: <CAEYw=Woe1ycyBRx=FtL9pQOhSr66-Njwr5x3VR_46DFMQ9W52w@...278...>
Content-Type: multipart/alternative; boundary="000000000000b82c6005876fd841"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net

--000000000000b82c6005876fd841
Content-Type: text/plain; charset="UTF-8"

Antonio & Jan Just,
I actually have verbose level 8 log files of the issue. :)

If you look at a normal connection (the initial one), a PUSH_REQUEST is
logged in the server as
PUSH: Received control message: 'PUSH_REQUEST'

After the reconnect however, I see the PUSH_REQUESTs being sent out by the
client, but I never see the above message on the server. Are the TLS calls
for the request usually logged before or after this message? I can then
check the log files to see what the difference between these two moments
are.

Kind regards,

Pieter Hulshoff

--000000000000b82c6005876fd841
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,helvetica,sans-serif">Antonio &amp; Jan Jus=
t,</div></div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif"></div><div class=3D"gmail_default" style=3D"font-family:ar=
ial,helvetica,sans-serif">I actually have verbose level 8 log files of the =
issue. :)</div><div class=3D"gmail_default" style=3D"font-family:arial,helv=
etica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:arial,helvetica,sans-serif">If you look at a normal connection (the init=
ial one), a PUSH_REQUEST is logged in the server as</div><div class=3D"gmai=
l_default" style=3D"font-family:arial,helvetica,sans-serif">PUSH: Received =
control message: &#39;PUSH_REQUEST&#39;</div><div class=3D"gmail_default" s=
tyle=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gma=
il_default" style=3D"font-family:arial,helvetica,sans-serif">After the reco=
nnect however, I see the PUSH_REQUESTs being sent out by the client, but I =
never see the above message on the server. Are the TLS calls for the reques=
t usually logged before or after this message? I can then check the log fil=
es to see what the difference between these two moments are.</div><br></div=
><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif">Kind regards,</div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:arial,helvetica,sans-serif">Pieter Hulshoff</d=
iv><br></div></div>

--000000000000b82c6005876fd841--


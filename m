Date: Wed, 22 Oct 2025 18:06:21 +0000
From: Joshua Rogers <contact@...2949...>
Message-ID: <AEnQPdqfGWjCz-mlg3_6apDcIz9cuBUpnlgwt8JdcOmoRUOI0J27hvmUpBBwktUlvL0sZxYIIgJT_q_k06xBnACDnbAPypNjq71D99xtCFM=@joshua.hu>
In-Reply-To: <aPhx4vGvodCxQ6KW@...1296...>
References: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
 <aPfhwvsB8Sk27GME@...1296...>
 <38497401-3a75-4885-8d0f-349c837d14a2@...1227...>
 <aPhx4vGvodCxQ6KW@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] tcp: apply CLOEXEC to accepted socket,
 not listener
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

By the way, as mentioned, this was found with the ZeroPath tool. I was wond=
ering if it would be of interest to send the raw results of this scanner to=
 somebody that could allow them to review the findings without me manually =
triaging? I have done this with curl (https://daniel.haxx.se/blog/2025/10/1=
0/a-new-breed-of-analyzers/) and it was quite succesful (~20% false positiv=
e rate).

If this is of interest, please let me know where to send them. The output i=
s just markdown, and it includes potential security vulnerabilities. If not=
, I will (slowly) continue triaging myself.

Thank you.

On Wednesday, 22 October 2025 at 13:55, Gert Doering <gert@...1296...> wrot=
e:

>=20
>=20
> Hi,
>=20
> On Tue, Oct 21, 2025 at 10:34:21PM +0200, Arne Schwabe wrote:
>=20
> > Before commiting we have to check that port-share does not rely on this
> > behaviour to pass the fd the forked instances. I didn't check right now.
>=20
>=20
> Good point. I have a port-share test instance, will test.
>=20
> gert
>=20
> --
> "If was one thing all people took for granted, was conviction that if you
> feed honest figures into a computer, honest figures come out. Never doubt=
ed
> it myself till I met a computer with a sense of humor."
> Robert A. Heinlein, The Moon is a Harsh Mistress
>=20
> Gert Doering - Munich, Germany gert@...1296...


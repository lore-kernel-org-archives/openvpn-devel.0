Date: Fri, 14 Oct 2022 17:24:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0l/IPVu988ffsYd@...1296...>
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
 <20221011110126.1798114-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aO+U8UtzE0I+g7QN"
Content-Disposition: inline
In-Reply-To: <20221011110126.1798114-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Change explicit exit notification to be
 a SIGUSR1 instead of a SIGTERM signal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--aO+U8UtzE0I+g7QN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 11, 2022 at 01:01:26PM +0200, Arne Schwabe wrote:
> From the implemention and the fact that it is a an OCC message
> (basically the rudimentary predecessor to control channel),
> this message is very old.
>=20
> I think in the past this feature fit nicely to the weird inetd + openvpn =
mode
> that seems to have far to many hacks still left in our code. With inetd,
> it made sense that the server instance quits if you press C-c on the clie=
nt.
>=20
> In our current state where inetd is no longer supported, this behaviour
> to exit makes little sense and this patch changes the behaviour to SIGUSR=
1.

I am very confused about v2 of this patch - and would be happy to ACK v1.

I have applied v1, and tested

 - p2p without the patch -> client sends EEN -> server exits
    2022-10-14 16:56:56 us=3D334517 Exit message received by peer
    2022-10-14 16:56:56 us=3D334753 TCP/UDP: Closing socket
    2022-10-14 16:56:56 us=3D334814 Closing TUN/TAP interface
    2022-10-14 16:56:56 us=3D334836 net_addr_v4_del: 10.204.11.1 dev tun11
    2022-10-14 16:56:56 us=3D334987 net_addr_v6_del: fd00:abcd:204:11::1/64=
 dev tun11
    2022-10-14 16:56:56 us=3D342133 SIGTERM[soft,remote-exit] received, pro=
cess exiting

 - p2p with the v1 patch -> client sends EEN -> server logs, and restarts

    2022-10-14 16:57:30 us=3D151079 Exit message received by peer
    2022-10-14 16:57:30 us=3D151254 TCP/UDP: Closing socket
    2022-10-14 16:57:30 us=3D151316 Closing TUN/TAP interface
    2022-10-14 16:57:30 us=3D151343 net_addr_v4_del: 10.204.11.1 dev tun11
    2022-10-14 16:57:30 us=3D151465 net_addr_v6_del: fd00:abcd:204:11::1/64=
 dev tun11
    2022-10-14 16:57:30 us=3D155086 SIGUSR1[soft,remote-exit] received, pro=
cess restarting
    2022-10-14 16:57:30 us=3D155149 Restart pause, 5 second(s)

    (and then it rearms itself and is ready to server another p2p client)


 - p2mp server without patch -> client sends EEN -> server logs, and=20
   terminates the instance

    2022-10-14 16:58:26 us=3D544309 cron2-freebsd-tc-amd64/194.97.140.21:17=
570 Exit message received by peer
    2022-10-14 16:58:26 us=3D544365 cron2-freebsd-tc-amd64/194.97.140.21:17=
570 SIGTERM[soft,remote-exit] received, client-instance exiting


 - p2mp server with the v1 patch -> client sends EEN -> server logs, and
   says it will "restart" the instance

    2022-10-14 16:59:02 us=3D113506 cron2-freebsd-tc-amd64/194.97.140.21:41=
691 Exit message received by peer
    2022-10-14 16:59:02 us=3D113573 cron2-freebsd-tc-amd64/194.97.140.21:41=
691 SIGUSR1[soft,remote-exit] received, client-instance restarting

 - with a 2.4 client, it has no "Exit message recived by peer" (because that
   is the new control channel thing), and just logs

    2022-10-14 17:03:47 us=3D455929 cron2-freebsd-tc-amd64/194.97.140.21:13=
152 SIGUSR1[soft,remote-exit] received, client-instance restarting


Trying to understand the code is an interesting maze... that message
above comes from sig.c::print_signal(), which is called from
"multi::multi_close_instance_on_signal()".

*That* one is called (mostly) from multi_process_post(), which says

" * Also close context on signal."

and basically does

    if (IS_SIG(&mi->context))
    {
        if (flags & MPP_CLOSE_ON_SIGNAL)
        {
            multi_close_instance_on_signal(m, mi);
            ret =3D false;
        }
    }

... so, the nature of the (soft) signal raised does not seem to play
any role to the instance - "if signal, then close instance".  Just the
logging is a bit off now ("restarting" vs. "exiting").


If we care about logging, I think we should do the signal remap in
multi_close_instance_on_signal()  (... which already remaps SIGUSR1
by means of remap_signal(), but only if c->options.remap_sigusr1 is
set).

OTOH, maybe it should just *not* call remap_signal(), as the per-instance
signals and the global signals do different things, and always remap
SIGUSR1-in-instance to SIGTERM...


What I do not think will make us happy in future is the extra=20
conditionals in v2...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aO+U8UtzE0I+g7QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjSX8gAAoJEB2Cnv7KVigSNpIL/i/Z6zojBeT4JAbxWpTbl4Ho
QWEQ0q/fGjuwIoJmH8DngBYa2yHUrtC7WS3o0pIskzFTXwwuiEI36myhPRl7M5Zi
RmRAIeuQlrSe13bEzXr2lSw/5u4P2Pb4TbTe+d9w7Lw81jCP9pmMmdlk8Q4bg1wo
YdAWIC8Uf+zWvS3i68pL5DOaGsOHQLg1NrT/3fRSJ4FSzrwp8juiLH+2xuZwvW2g
eu9qwJgexZqiMFtVZMnTEdL/LPpPJhE1jh9SmCwtaWhdvPJpP2kECIKgu35INTYj
kAKKtRetmJlEDswHOMFdNKv/uPkyt0kz92Z/1OAIgn71LqPz5AbTzmulWDyAY+8Y
DrehlGOwhMeWvO1lsRGEQ9ctDpLCFfyzygyvPgvPHpkdZO0H/14+kPifqZ2BZ5QP
7eRJAX6N6wm9gONlKUCIWQrX16junOUtsaZpSDGhCGCrya3ELV+w5wmg5H0xScsM
dHghrNBQeV+Iwi2LPfHdmpCmXikifRE8rj1Iwxk7VA==
=p1sO
-----END PGP SIGNATURE-----

--aO+U8UtzE0I+g7QN--


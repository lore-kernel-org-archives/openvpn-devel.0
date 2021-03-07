Date: Sun, 7 Mar 2021 22:28:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210307212830.GT976@...1296...>
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jaaGlYnsuL6Jp0Qt"
Content-Disposition: inline
In-Reply-To: <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jaaGlYnsuL6Jp0Qt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 07, 2021 at 02:20:32PM -0500, Selva Nair wrote:
> > That's another possible angle... just up soft+hard to "something"
> > (how much would that be? :-) ) and log the fact.
>=20
> Rereading my comment on Trac #1059 I recall testing this and concluding
> 100MB enough for clients. On modern machines that's a low amount of memory
> --- not allowing swapout of 100MB should be acceptable.  For servers, I
> think there is no reliable limit that we could come up with.

This is interesting.  My machines, including servers, have a way lower
memory usage - but I'm not using EC.

Here's a linux server with 3 peers and a client (arm32):

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     14569  0.0  0.5   5704  2980 ?        Ss    2020  12:31 openvpn
root     21020  0.1  0.5   5568  3040 ?        Ss    2020 454:45 openvpn

Here's a FreeBSD server that serves 5 clients right now, but has peaks
up to 150 concurrent clients (amd64)

USER      PID   %CPU %MEM    VSZ    RSS TT  STAT STARTED          TIME COMM=
AND
root     5023    0.3  0.1  30924  23172  -  Ss   20Dec20    1945:07.12 /usr=
/local/sbin/openvpn --cd /usr/local/etc/openvpn --daemon

... and another two Linux server instances...

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      1138  2.1  1.3  26732 10628 ?        Ss    2019 21678:18 /usr/sbi=
n/openvpn
root      2897  0.8  0.9  29548  7080 ?        Ss    2019 8596:15 /usr/sbin=
/openvpn


the last 3 see a high number of clients during work time, and quite
some churn (especially due to iOS/android connecting and disconnecting
frequently), but long-term memory usage is not high.

So there must be some massive transient usage due to EC at reconnection
time...


But anyway.  100M seems to be a good value, then.

I'll send a v2 of that patch, with setrlimit().

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jaaGlYnsuL6Jp0Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgRUV9AAoJEB2Cnv7KVigSytcMAJlzWMTu9csx4nHxBpjSdSH9
1ZNen5FgY58i+ki+LJsT6CozxaacaCVb/WhlwrdGywJzEFa3GJu62WDAbLPQE/aA
nqNsBljRyDs5jqQAtGNvG4FaghafSw4giheIHtRnJ6200BLwvEp7O70pRsSny/lX
7r4Oag1SnrJNdc3oP8T9GLXis0WvZ42JC5FNXoZxjWijocmU8K/t1jnuCzIhZBiT
txdQX8n/TQFdmC60i0FYt8rcx8Gu2jBtjxxWltAxeZQ0vZg+ZVOrplHMPkZTE+Om
cJHjJ2fgCQfROWFyQ+l3K4hU1d/19yG5FmHgr40ebK/Dc97ynRUsez9jVJ4BcOXK
dK1iKWXoEAXxreZFVoHlDVjrHnd0ATgB/gAUMSkkGNEiPiODAW+HFsccdO8q9ouY
KwV4AZlAbXVMSMMMV47zzt7tCsxQ1Dcelh6hAINYr5sz/eOWbQXIvQ8ak62LHddY
icOQedSr1suK1SCMq7KvI6GB8MQv4neSZx3gnw7y7Q==
=dy7X
-----END PGP SIGNATURE-----

--jaaGlYnsuL6Jp0Qt--


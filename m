MIME-Version: 1.0
References: <20230322113249.2039-1-lstipakov@...277...>
 <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
 <CAEUTVqR-S8fZkCh6JRrO5ZzeYAq+GiP4qFx5d7vhPDpXfjnUeg@...278...>
 <CAKuzo_hbC6vUNr0JURC8tM+pc=8F_F2UQkFjn7c-Rm24FUGVRQ@...278...>
 <CAEUTVqR2sCrjQ8=mnn0g-j4=eqtCPDQVs0AKxSw9fAr8PANWng@...278...>
In-Reply-To: <CAEUTVqR2sCrjQ8=mnn0g-j4=eqtCPDQVs0AKxSw9fAr8PANWng@...278...>
From: Lev Stipakov <lev@...515...>
Date: Thu, 23 Mar 2023 15:35:18 +0200
Message-ID: <CAEUTVqSTy1LFZh165c0t7MDoxuUrYz3JjCzgD2uX=TSD8CExnQ@...278...>
Subject: [Openvpn-devel] Fwd:  [PATCH] Print DCO client stats on SIGUSR2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

For reference, my comments.

---------- Forwarded message ---------
From: Lev Stipakov <lev@...515...>
Date: Thu, Mar 23, 2023 at 9:39=E2=80=AFAM
Subject: Re: [Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2
To: Selva Nair <selva.nair@...277...>


I see the point - we now have driver-specific code in functions
{multi}_print_status which are supposed to be driver-agnostic and it
doesn't scale well when/if we add another driver. Also in general it
feels wrong that
print_ functions do print-unrelated things, like calls to the network drive=
r.

I think in the long run we might want to get rid of
dco_read/write_bytes and just store dco stats into
link_read/write_bytes. I remember that in Linux (and likely in
FreeBSD?) we do initial handshake in userspace and
then switch to dco - probably that was the rationale of keeping link
and dco stats separately. Not sure if stats granularity justifies
complexity of adding driver-specific counters.

Your reply wasn't sent to -devel, not sure if it was intentional.

-Lev


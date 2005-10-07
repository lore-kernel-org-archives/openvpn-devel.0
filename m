Message-ID: <1e6368e80510071321w69edc7e2h13e2166eb3116b2a@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
In-Reply-To: <1128702738.7000.97.camel@...399...>
MIME-Version: 1.0
References: <43404D99.8080309@...361...> <434189C7.5090304@...361...>
	 <1128369731.6952.59.camel@...399...>
	 <4342703F.90607@...361...>
	 <1128428582.7061.18.camel@...399...>
	 <4342D092.4050502@...361...>
	 <1128619301.7000.58.camel@...399...>
	 <4346A01F.4030106@...361...>
	 <1128702738.7000.97.camel@...399...>
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
Date: Fri Oct  7 13:22:26 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Marcelo Toledo <marcelo@...461...>
Cc: Rolf Fokkens <r.fokkens@...361...>, openvpn-devel@lists.sourceforge.net

On 10/7/05, Marcelo Toledo <marcelo@...461...> wrote:
> Em Sex, 2005-10-07 =E0s 18:19 +0200, Rolf Fokkens escreveu:
> >
> > Could be a silly question, but to be sure: you had the client-to-client
> > option enabled on the server side?
>
> Yes we do.
>
> > The patch should work both on the client and the server, but for clients
> > it hardly does anything at all.
>
> alright, here what we have done.
>
> In the main server we installed the patch. We have ~400 clients
> connected to it, 3 of them we also installed the patch, here is the
> result.
>
> All these 3 clients couldn't see each other but they could see the
> remaining 397 clients. The 397 couldn't see the 3 clients.
>
> I think that's it, any idea?

What is common amonng the three that is different from the rest?

Maybe subnetting issue?  Does client-to-client work across subnets?

--
Leonard Isham, CISSP
Ostendo non ostento.


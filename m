Message-ID: <20060323222049.30857.qmail@...574...>
From: Iftikhar Qureshi <iftikharqureshi@...109...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
In-Reply-To: <000001c64ebf$5b8fd230$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-464720037-1143152448=:30851"
Content-Transfer-Encoding: 8bit
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
Date: Thu Mar 23 14:21:17 2006
To: Dave <dev@...575...>, openvpn-devel@lists.sourceforge.net

--0-464720037-1143152448=:30851
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Dave-
   
  I've downloaded the files from the link you sent me and configured the project according to recommended directory structure. Now I'm going through the source code.
   
  I've picked up the changed source code as well (unless you changed the file name). Unable to compile yet as I've not yet resolved all the dependencies.
   
  And BTW I ended up using PPC 2003 SDK :)
   
  Salamz,
  -IQ

  PS: Device I'm using is PPC-6700

Dave <dev@...575...> wrote:
  > -----Original Message-----
> From: openvpn-devel-admin@lists.sourceforge.net 
> [mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Dave
> Sent: Wednesday, March 22, 2006 8:30 AM
> To: 'Iftikhar Qureshi'; openvpn-devel@lists.sourceforge.net
> Subject: RE: [Openvpn-devel] OpenVPN for PocketPC

Iftikhar;

I updated the source at the web location I previously sent you in case you
want to pick it up. Here's a brief summary of what I've fixed/extended
since last time:

* I figured out my dynamic driver load/unload problem; it was a bug I
introduced in one of the ANSI/UNICODE functions that had the effect of
truncating the adapter name stored internally in NDIS. Curious that it
worked in the emulator anyway...
* I implemented several of the functions in tun.c (currently residing
wince_tun.c) and sifted away some that were win32-specific ones.
* I discovered yesterday that in the particular case of winsock, that
overlapped io support is required, and (supposedly) has been implemented in
CE and is available via the WSA versions of those methods (e.g.
WSAGetOverlappedResult). This is really good news because it possibly means
that all the socket.c work will not have to be reworked at all. Hopefully!

So I think that only the five various tun_* and *_tun methods need to be
implemented to declare this 'feature complete' and then the exciting phase
of testing/fixing begins.

-Dave



--0-464720037-1143152448=:30851
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Dave-</div>  <div>&nbsp;</div>  <div>I've downloaded the files from the link you sent me and configured the project according to recommended directory structure. Now I'm going through the source code.</div>  <div>&nbsp;</div>  <div>I've picked up the changed source code as well (unless you changed the file name). Unable to compile yet as I've not yet resolved all the dependencies.</div>  <div>&nbsp;</div>  <div>And BTW I ended up using PPC 2003 SDK :)</div>  <div>&nbsp;</div>  <div>Salamz,</div>  <div>-IQ<BR></div>  <div>PS: Device I'm using is PPC-6700<BR><BR><B><I>Dave &lt;dev@...575...&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">&gt; -----Original Message-----<BR>&gt; From: openvpn-devel-admin@lists.sourceforge.net <BR>&gt; [mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Dave<BR>&gt; Sent: Wednesday, March 22, 2006 8:30 AM<BR>&gt; To: 'Iftikhar Qureshi';
 openvpn-devel@lists.sourceforge.net<BR>&gt; Subject: RE: [Openvpn-devel] OpenVPN for PocketPC<BR><BR>Iftikhar;<BR><BR>I updated the source at the web location I previously sent you in case you<BR>want to pick it up. Here's a brief summary of what I've fixed/extended<BR>since last time:<BR><BR>* I figured out my dynamic driver load/unload problem; it was a bug I<BR>introduced in one of the ANSI/UNICODE functions that had the effect of<BR>truncating the adapter name stored internally in NDIS. Curious that it<BR>worked in the emulator anyway...<BR>* I implemented several of the functions in tun.c (currently residing<BR>wince_tun.c) and sifted away some that were win32-specific ones.<BR>* I discovered yesterday that in the particular case of winsock, that<BR>overlapped io support is required, and (supposedly) has been implemented in<BR>CE and is available via the WSA versions of those methods (e.g.<BR>WSAGetOverlappedResult). This is really good news because it possibly means<BR>that
 all the socket.c work will not have to be reworked at all. Hopefully!<BR><BR>So I think that only the five various tun_* and *_tun methods need to be<BR>implemented to declare this 'feature complete' and then the exciting phase<BR>of testing/fixing begins.<BR><BR>-Dave<BR><BR></BLOCKQUOTE><BR>
--0-464720037-1143152448=:30851--


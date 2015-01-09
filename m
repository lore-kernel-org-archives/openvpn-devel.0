MIME-Version: 1.0
In-Reply-To: <54AC78FD.3010806@...515...>
References: <54AC78FD.3010806@...515...>
Date: Fri, 9 Jan 2015 11:41:56 +0200
Message-ID: <CAGyAFMVnMc=CBHW+Z48_CKpm3SJ519B0fvbTLbUR+kqyoDPvPg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: Re: [Openvpn-devel] OpenVPN protocol extensions update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: James Yonan <james@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi James,

A few comments on peer-id part:

  * A disabled peer ID is denoted by 0xFFFFFF.
  * Server tells the client to use DATA_V2/peer_id by pushing
     the directive "peer-id ID" where ID is a decimal integer
     in the range [-1, 16777215].  Setting the peer ID to -1
     transmits DATA_V2 packets with the peer ID field set to
     0xFFFFFF.  Setting the peer_id to -1 is the same as
     setting it to 16777215 (i.e. 0xFFFFFF).

There is no such thing as "disabled peer-id" in current
implementation, server does not send "-1" and client does not send
0xFFFFFF. I can surely do it, if needed. Could you maybe explain its
meaning? And just to make sure - if server gets DATA_V2 with peer-id
-1, it should skip peer-id bytes and treat it as data_v1, correct?

There is no specific check for the max value of peer-id at the place
where peer-id is issued. Logic relies on max_clients option. So in
case if max_clients is set to 2^24 or above, peer-id will wrap. There
is a check, however, that peer-id is between 0 and max_clients in the
code which handles incoming data packets.

  * Server never pushes a "peer-id" directive unless the client has
indicated its support for DATA_V2 by including "IV_PROTO=2" in the
peer info data.

Server pushes peer-id if IV_PROTO>=2. Is it ok or should it be changed to =2 ?

  * ensure that the float doesn't clobber a pre-existing client (i.e.
if the address floated to is already owned by another client) unless
it can be verified that the pre-existing client is a previous instance
of the floating client.

Thanks to this mail, I've checked code again and found a bug - a lame
duck client may float to an address taken by another client. I have
submitted a fix:

http://thread.gmane.org/gmane.network.openvpn.devel/9386

which is waiting for an ACK.

Otherwise implementation is pretty much in line with your spec.

-Lev

2015-01-07 2:08 GMT+02:00 James Yonan <james@...515...>:
> I've updated the OpenVPN protocol extension doc with additional details, now
> that more of these features have been implemented in OpenVPN 3.
>
> If you are implementing any of these features in OpenVPN 2.x, please review
> so we can ensure that OpenVPN 2.x and 3 are on the same page with respect to
> protocol extensions.
>
> Changes:
>
> 1. Added specific details on DATA_V2/peer-id/float support.
>
> 2. For AEAD mode, emphasized that the leading 8 bytes (4 bytes for
> DATA_V2/peer-id and 4 for packet ID) is all included in the AD.
>
> 3. Added specific details on protocol negotiation where the client indicates
> protocol extension availability with IV_x parameters in the peer info
> string, and the server responds by pushing directives to the client to
> enable the feature.
>
> 4. Added "TCP nonlinear mode" section, a new protocol extension that is
> needed by multithreaded TCP servers.
>
> James
>
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming! The Go Parallel Website,
> sponsored by Intel and developed in partnership with Slashdot Media, is your
> hub for all things parallel software development, from weekly thought
> leadership blogs to news, videos, case studies, tutorials and more. Take a
> look and join the conversation now. http://goparallel.sourceforge.net
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



-- 
-Lev


Message-ID: <4F566CC4.6020403@...1490...>
Date: Wed, 07 Mar 2012 09:00:04 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
	<1331052472905814500@...1315...>
	<CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
	<1331055760398534500@...1315...>
	<CAOazyz2q-W7M8v3ubU1G=Wa2XLwfzqP2HCtH6tsLXfgxpXQ3BA@...278...>
	<4F565A70.5050907@...1114...>
	<CAOazyz3-H6KBcc2m5DuRwQsdiJuCZF7RbqnyvmisHUXBvZFUww@...278...>
In-Reply-To: <CAOazyz3-H6KBcc2m5DuRwQsdiJuCZF7RbqnyvmisHUXBvZFUww@...278...>
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 07/03/12 07:55, Alon Bar-Lev wrote:
> 1. Multi user computer - we need to make sure one user cannot use
> another user credentials and not effect the other users. With changes
> I suggested there is full solution for this.

Is that really a risk worth solving? I mean, does *anyone*, *anywhere*
allow *any* form of end-user triggered VPN access from a multi-user
machine? I cannot imagine (say) a Windows 2008 terminal server where
users have local administrator privileges (huh?!?) and are allowed to
create PPTP/L2TP/whatever links at will - it'd be chaos!

Here's what I see are the primary use-cases of openvpn (or any software
vpn really)

1. Using openvpn as a router. No need to worry about this - as there are
no local users
2. I believe anyone using openvpn on multi-user servers should be
expected to have set authentication details for the management interface
(or not use it at all...). Users wouldn't have admin privilege, so no
concerns with stealing creds from memory
3. single-user computers where users have local admin. Malware would be
an issue - but would be even with the best privilege separation (can you
say "keylogger"?)
4. single-user computers where users don't have local admin. Privilege
separation is a must for this scenario

Your comments on rogue servers is certainly worth discussing too. What
can a rogue openvpn server push back to a client? Routes obviously - but
other than screwing the client, is there any new risk? If the client has
"pull" enabled, it is implicit that there's the opportunity for the
client to find their network access corrupted by bad routes from the
server. As the server is meant to be able to push routes to the client,
I cannot see how that can ever be remediated (besides disabling "pull"
and/or using "route-noexec/route-nopull", etc). However, the server
can't tell the client to become a router (therefore opening up the
client's internal network to be accessible from the server), nor can it
force the client to create local accounts, install software, etc. So
what are the actual risks?

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1



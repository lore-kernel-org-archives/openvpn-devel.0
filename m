Message-ID: <ef71481e-c083-91c3-2daa-7cf41fc267b0@...1227...>
Date: Fri, 5 May 2023 12:54:47 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <ZFSsu3eazsdo8zoA@...1152...> <ZFSxQELSohwLfK-V@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ZFSxQELSohwLfK-V@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] auth-token-user/auth-token
 issue with "TLS Auth Error: username attempted to change"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Am 05.05.23 um 09:33 schrieb Gert Doering:
> Hi,
> 
> On Fri, May 05, 2023 at 09:14:03AM +0200, Ralf Hildebrandt via Openvpn-users wrote:
>> May  5 09:06:00 openvpn-gw170-int openvpn-udp[29574]: hildeb/10.31.192.115:55334 TLS Auth Error: username attempted to change from 'hildeb' to 'hildeb::1f047fb6' -- tunnel disabled
>> May  5 09:06:00 openvpn-gw170-int openvpn-udp[29574]: hildeb/10.31.192.115:55334 TLS Auth Error: Auth Username/Password verification failed for peer
>>
>> What do we have to do to make the server accept the the
>> auth-token-user it pushed to the client?
> 
> As of today, there is no way to make it do that.  On initial TLS
> authentication, the session is tied hard to the initial username(*),
> and changing username on reauthentication is not allowed.
> 
> That said, this breaks at least two use cases
> 
>   - there was no initial username/password authentication at all - and
>     you absolutely need auth-token-user here, to make the client actually
>     send the auth-token back.  It fails, because the server is locked
>     to "empty username" - I have sent a patch for this, but Arne is not
>     fully agreeing with me that it's the right thing
> 
>   - actually *changing* the auth-token-user from an original username/password
>     authentication - it runs into the same problem, but this might be
>     workaroundable by not actually pushing a new "user".  So, question to
>     you, what is the intention behind changing the username here?
> 
> 
> For "my case", I think handling the "username was empty before" case
> specially is the easy way forward (even if Arne disagrees), but for
> "your case" we'd need to disable the "tie TLS session to username",
> which is a no-go for Arne...

So the empty username is problematic since we use the auth-token to 
reauthenticate with that username and then OpenVPN will tell you that 
you have an empty username that is fully authenticated. And I am not 
sure what that would mean in any context. Also if you have no username, 
you either need to track the session in the auth token to ensure that 
you the same user as before or that session could be used with any 
certificate.

For changing the username, that looks simple on the first glance but we 
need to carefully go through our to see where the username is 
used/locked in our code to understand what implications this has.

Arne



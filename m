Message-ID: <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
Date: Wed, 23 Oct 2024 17:40:43 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
From: Razvan Cojocaru <rzvncj@...277...>
In-Reply-To: <ZxkG_T7Jw7fI-C1I@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/23/24 17:23, Gert Doering wrote:
> Hi,
> 
> On Wed, Oct 23, 2024 at 04:49:03PM +0300, Razvan Cojocaru wrote:
>> This in turn allows the server to signal to the client that it
>> should no longer attempt to reconnect, if it wants to keep the
>> client out after an AUTH_FAILED.
> 
> This should not be necessary.  After an AUTH_FAILED the token is
> already invalidated on the client side.
> 
> Can you describe your use case a bit better?  This code is complex
> enough as it is, so I'm not really willing to add more cases to it
> (which I do have to test then and forever) if not needed.

Thanks for the quick reply!

Of course! The use case pertains to the device posture checks that 
OpenVPN has rolled out.

Long story short, these are meant to allow the server to make decisions 
on whether the client is allowed to connect (and stay connected, which 
is the part I'm addressing here) based on information about it.

For example, if it has an up-to-date antivirus, or if it has full disk 
encryption enabled.

So a client may connect and be allowed in, then for some reason its 
antivirus may not be updated for a considerable while, at which point a 
check will want to disconnect said client. Reconnects will be possible 
after whoever manages the client machine updates the antivirus.

In this case, we want to disconnect the client and it should stay 
disconnected. A simple AUTH_FAILED for this scenario will have the 
client attempt another connection. But if we invalidate the token, then 
the client will not attempt to reconnect.

Another reason for this patch is that the OpenVPN 3 client does allow 
setting the auth-token to an empty string, and when it is empty the 
logic is to not reconnect - so this would allow both version 2 and 
version 3 clients to behave the same way.


Thanks,
Razvan


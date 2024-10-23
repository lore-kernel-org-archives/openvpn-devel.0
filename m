Message-ID: <babedac6-d487-4df6-b054-b961209be459@...277...>
Date: Wed, 23 Oct 2024 18:01:49 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
 <ZxkLm_LadCi16JTV@...1296...>
 <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
 <ZxkNPBAus8JGMehg@...1296...>
From: Razvan Cojocaru <rzvncj@...277...>
In-Reply-To: <ZxkNPBAus8JGMehg@...1296...>
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

On 10/23/24 17:50, Gert Doering wrote:
> OK, so I see what is happening - you're sending an AUTH_FAILED "out of
> the blue", not in response to a client handshake, right?

Exactly. In response to a client handshake there's no problem.

> OpenVPN 2 *should* invalidate the token upon the reconnect (and then
> getting an AUTH_FAILED)... so what happens in this case if you let it
> reconnect?

If we let it reconnect, the first re-connection attempt will fail at the 
handshake stage as expected.

But OpenVPN GUI tools will tend to show _two_ failed connections (the 
first "out of the blue" AUTH_FAILED one, and the second actual one), 
which is confusing for clients.


Thanks,
Razvan


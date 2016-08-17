Message-ID: <57B453A0.6000904@...1147...>
Date: Wed, 17 Aug 2016 14:08:00 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAKuzo_jc_mm2165qwc5ACLQCP6kqocRxfaMO9crJzu3HMxJ_og@...278...>
In-Reply-To: <CAKuzo_jc_mm2165qwc5ACLQCP6kqocRxfaMO9crJzu3HMxJ_og@...278...>
Subject: Re: [Openvpn-devel] testing challenge-response
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Selva,

Selva Nair wrote:
> Hi,
>
> As discussed in the IRC meeting, here is a client config that connects 
> to a test server I run for static and dynamic challenge. Just run it as
>
> sudo openvpn --config cr-client.conf
>
> Respond with some arbitrary strings at the username,  password and 
> static-challenge prompts and the server will send back the strings you 
> typed plus a dynamic challenge question. The connection will succeed 
> after the server verifies the response to the dynamic challenge. There 
> may be a 5 seconds restart pause between the two exchanges. 
>
> Note that the password and static-challenge response are sent by the 
> client to the server base64 encoded, but my server-side script sends 
> them back decoded, along with the dynamic challenge. This is done so 
> that the correctness of the first round exchange can be tested at the 
> client side. The response to the dynamic challenge is verified at the 
> server side and a successful connection indicates that the 
> verification passed.
>
> To do this using your own server, I'll post the script doing the 
> client-auth at the server side and the server config later today. In 
> the mean time please test this against my server.

thanks for your config files! I've just tested this against your server, 
and got a successful login on the second attempt. The challenge
  please answer this : 1+1 =
failed with a message:
  Wrong answer to dynamic response or invalid format (2.000 23.000)

but the second challenge worked fine. Next, I'll play with your server 
config.

cheers,

JJK



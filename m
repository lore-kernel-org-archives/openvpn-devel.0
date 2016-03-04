Message-ID: <56D9EB59.8010507@...1147...>
Date: Fri, 04 Mar 2016 21:08:57 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <56D8A6C4.5080803@...2070...>
	<56D989C7.5040403@...1227...>	<56D98B2E.20903@...2070...>
	<56D98CA8.8060307@...1227...>
In-Reply-To: <56D98CA8.8060307@...1227...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: ValdikSS <iam@...2070...>, openvpn-devel@lists.sourceforge.net

Hi,

On 04/03/16 14:24, Arne Schwabe wrote:
>
> Am 04.03.16 um 14:18 schrieb ValdikSS:
>> On 03/04/2016 04:12 PM, Arne Schwabe wrote:
>>> Am 03.03.16 um 22:04 schrieb ValdikSS:
>>> Shouldn't sending the new CA chain only be enough? Since it is
>>> (cross)signed by the old CA, the client will accept it. For the old
>>> clients the new CA will look like an intermediate certificate.
>> Please clarify what do you mean. I'm trying to send new CA (signed by old CA) and a server certificate.
>>
> Exactly what David Woodhouse replied just 10 minutes before my email.
>
>
the more I think about it, the more I think that what you are trying to 
achieve ought not to work:

your current situation is this:
- clients are equipped with a 1024bit CA cert; the server certificate 
(chain) must be signed using this end-entity CA cert for the client to 
trust the server
- the server supplies this 1024bit CA cert, as well as a cross-signed 
4096bit CA cert and a server cert.
- The client will never "accept" the 4K CA cert as the new end-entity, 
as that is not configured in the config file.

*but*
anything signed using a 1K cert should be considered insecure, as it's 
feasible nowadays to brute-force generate a key that will match that 
certificate. That means that an attacker can grab your 1K CA cert, 
generate a new CA key for it, then generate new server cert (or even a 
4K cross-signed CA cert) and lure an unsuspecting client to the server - 
your shiny new cross-signed CA cert will not prevent this.

The only way to prevent this from happening is by getting the clients to 
stop trusting/using the 1K CA cert - thus, you must alter the 
client-side configuration for this, painstaking as it is...


JJK



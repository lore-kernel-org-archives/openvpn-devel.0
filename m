Message-ID: <53037CD4.7020700@...277...>
Date: Tue, 18 Feb 2014 16:31:32 +0100
From: pietrek -- <pietrek.j@...277...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...> <20140218085500.GU16637@...1296...>
	<530340C4.5060702@...277...>
	<20140218115015.GW16637@...1296...>
In-Reply-To: <20140218115015.GW16637@...1296...>
Subject: Re: [Openvpn-devel] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 02/18/14 12:50, Gert Doering wrote:
> Hi,
>
> On Tue, Feb 18, 2014 at 12:15:16PM +0100, pietrek -- wrote:
>>> Which parts of the key handshake does it cover?  Signature/Certificates,
>>> or *only* DH?
>> Handshake only, EC certificates worked for me without doing anything.
>> Also, DH didn't work with EC certificates( no such cipher ).
> I see.
>
> Seems what we need as well is a README file that explains about EC crypto,
> as in
>
>   - how do I generate and use an EC certificate?
>   - how do I use an EC curve for DH?
>   - how do I use EC for session keying?
>
> because otherwise our users will be even more confused than I am.
>
> gert
>
Hi Gert,
Usage of EC curves is very simple. You can use them for certificates as 
well as RSA, but are smaller and generate faster.
Full list of curves you can get typing:
openssl ecparam -list_curves
> - how do I generate and use an EC certificate?
openssl ecparam -out ec.key -name sect571r1 -genkey
You can also extract public key:
openssl ec -in ec.key -pubout -out ec.pubkey
Now it ec.key can be used to generate certificate as well as RSA.
> - how do I use an EC curve for DH?
Simply add to openvpn server.conf line:
ecdh sect571r1
( I have created this option in my patch )
> - how do I use EC for session keying?
I've never seen eliptic curve as a key for session.
We use them for key negotiation or in certificates.

Piotr Jarosz



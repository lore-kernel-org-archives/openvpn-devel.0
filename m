Message-ID: <4CA09A9F.6040009@...1147...>
Date: Mon, 27 Sep 2010 15:22:39 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4CA0551F.70703@...1410...>
	<4CA08840.3030107@...1147...>	<4CA088DD.5040607@...1410...>
	<4CA08C68.1080701@...1147...> <20100927124711.GS3275@...1355...>
In-Reply-To: <20100927124711.GS3275@...1355...>
Subject: Re: [Openvpn-devel] HTTP/1.1 Host header
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
To: Heikki Kallasjoki <heikki.kallasjoki@...124...>
Cc: openvpn-devel@lists.sourceforge.net

Hi ,

Heikki Kallasjoki wrote:
> On Mon, Sep 27, 2010 at 02:22:00PM +0200, Jan Just Keijser wrote:
>   
>> ah right, now I see... hmmm 'Host: ...' headers should not be required 
>> by a web server and with apache's Virtual Hosts you can override this using
>>     
>
> I would have to disagree with whether Host: headers should be required,
> given that the HTTP/1.1 specification explicitly says [RFC2616]:
>
> "All Internet-based HTTP/1.1 servers MUST respond with a 400 (Bad
> Request) status code to any HTTP/1.1 request message which lacks a Host
> header field."
>
> The client also "MUST" send a Host: header in every request, it is not
> an optional field.  Changing only the version number on the CONNECT line
> OpenVPN sends does not make it a real HTTP/1.1 request.
>
> (From what I can tell, and based on a very quick test, the string
> "_default_" in an Apache <VirtualHost> config also only matches unlisted
> IP addresses, and does not change how it processes HTTP requests that
> claim to be version 1.1 but aren't.)
>
>
>   
now I see where the confusion is coming from : by default openvpn is 
using HTTP/1.0 requests; RFC1945 (http 1.0 standard) does NOT specify 
that the Host: header should be present. This was added in HTTP/1.1 
RFC2616 ; so I guess that whenever you specify HTTP/1.1 requests using
  --http-proxy-option VERSION 1.1
then OpenVPN should also send a 'Host: ' header - seems like a trivial 
fix to me. I still have no clue why the original patch was not accepted, 
but then again, the mechanism for entering patches has changed 
(improved!) a lot as of late.

HTH,

JJK




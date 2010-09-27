Message-ID: <4CA08C68.1080701@...1147...>
Date: Mon, 27 Sep 2010 14:22:00 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4CA0551F.70703@...1410...> <4CA08840.3030107@...1147...>
	<4CA088DD.5040607@...1410...>
In-Reply-To: <4CA088DD.5040607@...1410...>
Subject: Re: [Openvpn-devel] HTTP/1.1 Host header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Lars Hupel <hupel@...1410...>
Cc: openvpn-devel@lists.sourceforge.net

Lars Hupel wrote:
>> I'm not sure if I understand the question ; openvpn already has the
>> option to use http/1.1 headers using
>>  --http-proxy-option VERSION 1.1
>> which should send HTTP/1.1 type messages - doesn't that work?
>>     
>
> The problem is that (at least Apache) rejects these requests because the
> Host header is missing, so I get "Bad Request" responses.
>
> Additionally, without Host header it's impossible to use Apache's
> VirtualHost facility.
>
> Regards
> Lars
>
>   
ah right, now I see... hmmm 'Host: ...' headers should not be required 
by a web server and with apache's Virtual Hosts you can override this using

    <VirtualHost _default_:1234>
    DocumentRoot /www/default1234
    ...
    </VirtualHost>

    <VirtualHost _default_:80>
    DocumentRoot /www/default80
    ...
    </VirtualHost>

etc but this seems like an easy patch. Perhaps someone else on the -devel list can comment on why it was not accepted...

cheers,

JJK








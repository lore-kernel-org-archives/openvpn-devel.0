MIME-Version: 1.0
In-Reply-To: <938A4CDB-D912-421E-8059-4B40E0CD0791@...2127...>
References: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
	<938A4CDB-D912-421E-8059-4B40E0CD0791@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 5 Jun 2016 09:25:43 +0200
Message-ID: <CAA1AbxLTqKF-Bqz1zg4kC3=-SUP3FMQqxXLuy=-CnAspiFQiyw@...278...>
Subject: Re: [Openvpn-devel] travis-ci (smoke testing)
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
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, Jun 5, 2016 at 2:16 AM, Jens Neuhalfen
<openvpn-devel@...2127...> wrote:
>> (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3 does
>> not compile openvpn with openssl)
>
> Very strange, the cert is valid till 2017.

There seems to be some load balancing / CDN going om at mbed.org.  My
browser also gets a cert that's valid till 2017, but openssl s_client
-connect tls.mbed.org:443 gives me a cert that's valid till Oct 2016.
I guess the XCode 6.4 travis setup uses some permutation of the ssl
connection manages to trigger receiving an expired certificate.  I'll
notify the mbed people.

-Steffan


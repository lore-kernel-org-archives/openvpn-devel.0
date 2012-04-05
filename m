Message-ID: <4F7DF8D6.7060505@...1227...>
Date: Thu, 05 Apr 2012 21:56:06 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
	<4F5000C2.5020902@...1400...>
In-Reply-To: <4F5000C2.5020902@...1400...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
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
To: James Ring <sjr@...1546...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 02.03.12 00:05, schrieb Arne Schwabe:
>
>>> ... and for the rest, well, we'd need a volunteer that wants to
>>> *work* on
>>> this, not just ask for it...  I don't have an Android device (and no
>>> time) so it wouldn't be me.
>> I'm raising my hand. This path sounds better than what I thought would
>> be necessary (writing OpenVPN client implementation in Java). I'm also
>> asking around here at Google to see if somebody with more experience
>> with Android is interested in helping out. I'm sure there is
>> sufficient interest on both sides (Android and OpenVPN) to get
>> something working. This would make a niche segment of Android users
>> very happy I'm sure.
>>
> Are you already actively working on this? Otherwise I would start
> working on the feature. I have already some experience with the
> android sdk and ndk. I think I would solve the problem of fd passing
> and so on by turning openvpn into a JNI library.
>
I have managed to hack a proof of concept together. (Screen shot here: 
http://plai.de/android/Bildschirmfoto%202012-04-05%20um%2021.00.57.png)

The core VPN functionality already works. What needs to be done is 
proper error handling and configuration, espically integeration of 
Androids certificate Managment).

Arne



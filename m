Message-ID: <5346A91B.8070505@...1227...>
Date: Thu, 10 Apr 2014 16:22:19 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140406083549.GG16637@...1296...>
	<20140406085311.GH16637@...1296...>
	<20140407201711.GN16637@...1296...>
	<53430F50.4040709@...1227...>
	<20140408191204.GH16637@...1296...>
In-Reply-To: <20140408191204.GH16637@...1296...>
Subject: Re: [Openvpn-devel] getaddrinfo() confusion / way forward?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 08.04.14 21:12, schrieb Gert Doering:
> Hi,
>
> On Mon, Apr 07, 2014 at 10:49:20PM +0200, Arne Schwabe wrote:
>> Am 07.04.14 22:17, schrieb Gert Doering:
>>> On Sun, Apr 06, 2014 at 10:53:11AM +0200, Gert Doering wrote:
>>>> A slightly simpler version of this could go to the beginning of
>>>> create_socket() (--> no ai_next chain walking needed, etc.).
>>> Arne suggested an even more simple version of this - which is convincing,
>>> because it takes away lines of code, instead of adding more :-)
>>>
>>> Patch attached.  (Tested, works!)
>> ACK from me to basically my own patch.
> Well, it's an interesting turn of events :-) - I'll commit that with
> you as an author, and signed-off-by: lines from both of us.  OK?
>
>
Okay for me.

Arne


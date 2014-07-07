Message-ID: <53BADE4A.4040609@...1227...>
Date: Mon, 07 Jul 2014 19:52:10 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
	<1402244175-31462-4-git-send-email-steffan@...1856...>
	<53BA6036.3030305@...1227...> <53BADAE4.5040903@...1856...>
In-Reply-To: <53BADAE4.5040903@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Improve --show-ciphers to show if a
 cipher can be used in static key mode
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 07.07.14 19:37, schrieb Steffan Karger:
> On 07-07-14 10:54, Arne Schwabe wrote:
>> Am 08.06.14 18:16, schrieb Steffan Karger:
>>> Also remove the bulky warning from init_key_type() and add the information
>>> to the --show-ciphers output.
>>>
>> It does what it says but I think most users will be confused about what
>> (SSL mode only) is about. Most people which are not familar with openvpn
>> will not parse it as "non --static mode".
> Hmm, you're right. I'm not very good at this sort of thing. What about
> "(no static key mode)"? Any other suggestions?
>
Maybe (tls-client/tls-server mode only) or (Not in --static mode)? That
way the users knows what option you are referring to?

Arne


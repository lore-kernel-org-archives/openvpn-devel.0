Message-ID: <83d59a00-7c5f-0b34-aceb-857c08af872b@...1227...>
Date: Wed, 19 Oct 2022 13:21:59 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220824093723.64618-1-arne@...1227...>
 <20220914172527.2661529-1-arne@...1227...>
 <YyM0WAn0tZ1vj4N6@...2678...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YyM0WAn0tZ1vj4N6@...2678...>
Subject: Re: [Openvpn-devel] [PATCH v3] Improve data key id not found error
 message
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net


>> Patch v2: fix comparing key_id to state value, improve message
>> Patch v3: also take key_id into account
> 
> Code looks good to me now. Is there any way of testing this?

You need to get both peer in some kind of inconsistent state. Like short 
reneg-sec on one side and dealyed auth on the other side or deauthing 
(e.g. via management) and seeing packet in the last five seconds before 
the session gets killed. Also somethning like reneg-sec 60 on one side 
might trigger these warnings.

If I trigger them again with something reliable to trigger them, I will 
follow up.

Arne



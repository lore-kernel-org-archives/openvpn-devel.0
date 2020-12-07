References: <a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...>
 <f69a02a5-4e06-00ad-366e-56f5699c4d98@...1147...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e0af59b0-2310-7ce3-482e-2353c7ce1203@...2181...>
Date: Mon, 7 Dec 2020 10:56:08 +0100
MIME-Version: 1.0
In-Reply-To: <f69a02a5-4e06-00ad-366e-56f5699c4d98@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] AES-CCM available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Jan Just, Tony,

On 07/12/2020 10:10, Jan Just Keijser wrote:
> Thank you very much for adding this so quickly; it won't help Tony He
> though, as he is stuck using a rather old AL314 + R9000 chip which does
> not support CCM or GCM. I just checked the driver code and indeed there
> is no HW support for GCM.  They *do* support some AEAD algorithms:
> 
>   authenc-hmac-sha256-cbc-aes
>   authenc-hmac-sha384-cbc-aes
> 
> which are listed as the (true) AEAD equivalent of AES+SHA ; the question
> is : how hard would it be to add support for this (and would it be worth
> it?)

I would ask the same question to the vendor: how hard would it be to
support AES-GCM in the current HW engine?

Any info about that?
They are the best recipient for such feature request I think.

As far as I understood the HW engine is also open source, so actually
anybody with the right motivation could take up that task.


Forcing ourselves to sticking to legacy algorithms is not the right
move, imho (especially when there are solutions - see above).
To answer your question: my feeling is that working on it is not worth
the benefit.


Regards,


-- 
Antonio Quartulli


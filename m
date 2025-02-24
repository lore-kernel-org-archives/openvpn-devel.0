Message-ID: <a817801f-4dcd-48e2-b210-891b341342d5@...1227...>
Date: Mon, 24 Feb 2025 14:38:47 +0100
MIME-Version: 1.0
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
 <baac3422-1f0b-4587-bef6-0e23f8b6a296@...1227...>
 <CAAWBBYPh5gUvLrdkSXyzGcwn7FP-VUVQXg1pHpPbjemdknzY=w@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAAWBBYPh5gUvLrdkSXyzGcwn7FP-VUVQXg1pHpPbjemdknzY=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'localhost' token to client-nat
 network option
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
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 23.02.25 um 20:05 schrieb Rafael Gava:
> Hi Arne,
> 
> Thank you for your feedback.
> 
> I agree with your suggestion and will replace the localhost token with 
> 'assigned-ip' before resubmitting the patch.
> 
> Regarding your question about testing P2P, I haven't tested it yet. Do 
> you happen to have a configuration I could use for this scenario?
> 

openvpn-examples man page:

    Example 2: A tunnel with self-signed certificates and fingerprint

Arne


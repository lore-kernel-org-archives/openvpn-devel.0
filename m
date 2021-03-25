References: <20210325000121.10331-1-arne@...1227...>
 <2d571572-e3c0-9d9b-81a7-ccb5f8bd0736@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <016c3086-965b-2c78-9769-59f60551cf36@...2181...>
Date: Thu, 25 Mar 2021 08:49:31 +0100
MIME-Version: 1.0
In-Reply-To: <2d571572-e3c0-9d9b-81a7-ccb5f8bd0736@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Deprecate non TLS mode in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 01:47, tincanteksup wrote:
> I made this change to the wiki:
> https://community.openvpn.net/openvpn/wiki/DeprecatedOptions?action=diff&version=45

I had this discussion with "Pippin_" in #openvpn-meeting:

The change you made is wrong. That part of the wikipage talks about
moving the --genkey argument "secret" from being a standalone "--secret"
to "--gen key secret".

It is unrelated to the "non-TLS mode --secret" that Arne is talking
about in this PATCH.

That change (that was *Actually* made in 2.4) was exactly to remove this
ambiguity.

Since 2.4, you specifu the "secret" argument of "--genkey" by using the
"secret" subargument instead of passing the ambiguous "--secret".

For this reason I believe that this change on the wiki should be reverted.

Regards,

-- 
Antonio Quartulli


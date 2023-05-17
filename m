From: Kristof Provost <kp@...1376...>
Date: Wed, 17 May 2023 17:04:19 -0400
Message-ID: <DEA80ADA-574E-431E-A61E-89F4840AD9AF@...1376...>
In-Reply-To: <CAFHpkQER6g7MPu07_0TbKnnvc6poGsD2nZqLyATFXQN4JwiseQ@...278...>
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
 <CAFHpkQER6g7MPu07_0TbKnnvc6poGsD2nZqLyATFXQN4JwiseQ@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
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
To: =?utf-8?b?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 17 May 2023, at 16:58, Илья Шипицин wrote:
> ср, 17 мая 2023 г. в 22:43, Kristof Provost <kp@...1249...>:
>
>> On 17 May 2023, at 16:01, Ilya Shipitsin wrote:
>>> malloc was not checked against NULL, I was able
>>> to get core dump in case of failure
>>>
>>> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
>>> ---
>>>  src/openvpn/dco_freebsd.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
>>> index 1111abeb..adbd1120 100644
>>> --- a/src/openvpn/dco_freebsd.c
>>> +++ b/src/openvpn/dco_freebsd.c
>>> @@ -594,6 +594,11 @@ dco_available(int msglevel)
>>>      }
>>>
>>>      buf = malloc(ifcr.ifcr_total * IFNAMSIZ);
>>> +    if (buf == NULL)
>>> +    {
>>
>> I’d ‘goto out;’ instead, because that’s how we handle other errors in this
>> function.
>> (free(NULL) is guaranteed to be safe, so we can just do that.)
>>
>
> on "goto out" we'll end with "return available;"
>
‘available’ defaults to ‘false’, so that seems fine to me.

Best regards,
Kristof


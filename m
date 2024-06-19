Message-ID: <047ff0f4-a1f5-461b-9a8e-044789fa885f@...277...>
Date: Wed, 19 Jun 2024 13:47:01 +0200
MIME-Version: 1.0
References: <20240619103004.56460-1-gert@...1296...>
Content-Language: en-US
From: =?UTF-8?Q?Reynir_Bj=C3=B6rnsson?= <reynirr@...277...>
In-Reply-To: <20240619103004.56460-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Properly handle null bytes and
 invalid characters in control messages
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
To: openvpn-devel@lists.sourceforge.net

Hi,

I noticed a typo in a comment which is easy to understand correctly but 
makes it technically incorrect:


> +            /* commands on the control channel are seperated by \0x00 bytes.
> +             * cmdlen does not include the 0 byte of the string */
Here I think \0x00 should be \x00 (or \000 or some other way to write 
the NUL byte).


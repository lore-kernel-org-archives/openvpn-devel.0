References: <NaAsPRnb2g-raEjxjv15C_odADru2NIyXCs5wvZO609b_-4IqW2Do2sVbBull-FE9myUOZ7lNV6gdAx7MGugGUOBbdYOFO8AsoFHu35BIs8=@protonmail.com>
 <64a78361-8b16-a924-99f4-fec954a78412@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <125e5f6a-ff0c-7442-225b-91875774e22f@...2080...>
Date: Wed, 12 Feb 2020 16:01:26 +0100
MIME-Version: 1.0
In-Reply-To: <64a78361-8b16-a924-99f4-fec954a78412@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] openssl: alternative names support for
 --verify-x509-name CN checks
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
To: Arne Schwabe <arne@...1227...>, Mateusz Markowicz <poniekad@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/02/2020 15:39, Arne Schwabe wrote:
>> +bool
>> +x509v3_is_host_in_alternative_names(mbedtls_x509_crt *cert, const char
>> *host, bool *has_alt_names)
>> +{
>> +    msg(M_WARN, "Missing support for subject alternative names in
>> mbedtls.");

I'm not happy about this at all.  This should be possible to achieve with
mbed TLS as well:
<https://tls.mbed.org/api/structmbedtls__x509__crt.html#a1f148e8fb52e03e2604e716386a07df4>

One starting point for this can probably found here:
<https://tls.mbed.org/api/group__x509__module.html#ga033567483649030f7f859db4f4cb7e14>


-- 
kind regards,

David Sommerseth
OpenVPN Inc



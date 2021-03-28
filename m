References: <20210325000121.10331-1-arne@...1227...>
 <20210325000121.10331-2-arne@...1227...>
 <b418f610-6e7e-ba3c-8c30-6e0ef0c50fa5@...2181...>
 <20210326065851.GP976@...1296...>
 <4d294744-b5d1-22a2-2723-80a1cad3005c@...1227...>
 <48334b64-b24f-f412-0188-502cc9f70cf5@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3e955d96-b86d-eabf-0054-be7578c553ce@...1227...>
Date: Sun, 28 Mar 2021 14:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <48334b64-b24f-f412-0188-502cc9f70cf5@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] Remove deprecated option '--keysize'
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
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


> 
> Regarding mbedtls I am not sure how it is related to calling
> EVP_CIPHER_CTX_set_key_length.
>

That was probably misleading. I wanted to say that the mbed variant of
this function actually still has a more useful check in this function.
So I wanted to keep both checks rather than to remove both.

Arne


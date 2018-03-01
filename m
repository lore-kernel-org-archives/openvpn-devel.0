MIME-Version: 1.0
In-Reply-To: <CAKuzo_jEv2d7sNpi_ER-BFCeyOhmvGvV3GTKdw_L9Y0s=a6euA@...278...>
References: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
 <CAKuzo_jEv2d7sNpi_ER-BFCeyOhmvGvV3GTKdw_L9Y0s=a6euA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Mar 2018 15:40:11 -0500
Message-ID: <CAKuzo_gwH4QcTY5WRFsda6rKnUOZg4Tgxj2qqUsipd1i6Xdsew@...278...>
Subject: Re: [Openvpn-devel] tls fix for upcoming 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,


>
>> --- openvpn-2.4.5/src/openvpn/openssl_compat.h.orig 2018-02-28 21:56:54.000000000 +0100
>> +++ openvpn-2.4.5/src/openvpn/openssl_compat.h 2018-03-01 11:44:57.000000000 +0100
>> @@ -672,14 +672,18 @@
>>      {
>>          return TLS1_VERSION;
>>      }
>> +#ifdef SSL_OP_NO_TLSv1_1
>>      if (!(sslopt & SSL_OP_NO_TLSv1_1))
>>      {
>>          return TLS1_1_VERSION;
>>      }
>> +#endif
>> +#ifdef SSL_OP_NO_TLSv1_2
>>      if (!(sslopt & SSL_OP_NO_TLSv1_2))
>>      {
>>          return TLS1_2_VERSION;
>>      }
>> +#endif
>>      return 0;
>>  }
>>
>> #endif /* SSL_CTX_get_min_proto_version */
>
> These ifdefs are needed for older openssl (e.g., 0.9.8), but how did we miss it?
>
> Turns out commit 2d705accea3e538a555631ef7c39eb4bc4fd4acf cherry-picked
> from f8a92a4393a was not fully ripe..
>
> As we do not support Windows build using pre 1.0 openssl, this is the
> only change needed. So ACK, assuming a commit message and Author: may
> be slapped on during merge.
>
> Acked-by: Selva Nair <selva.nair@...277...>

Forgot to add: 2.4 only.  Master is good as is.

Selva


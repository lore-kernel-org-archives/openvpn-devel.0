From: Arne Schwabe <arne@...1227...>
References: <1464694953-3681-1-git-send-email-pinkel@...277...>
	<574D81F8.9000607@...1435...>
Message-ID: <6ce4e0d0-f71c-636e-4440-39ef9b89891d@...1227...>
Date: Tue, 31 May 2016 14:47:51 +0200
MIME-Version: 1.0
In-Reply-To: <574D81F8.9000607@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2.3] Plug memory leak in mbedTLS backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net



Am 31.05.16 um 14:22 schrieb Steffan Karger:
> On 31-05-16 13:42, Ivo Manca wrote:
>> Signed-off-by: Ivo Manca <pinkel@...277...>
>> ---
>>  src/openvpn/ssl_verify_polarssl.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
>> index 7ed87d6..cc46b75 100644
>> --- a/src/openvpn/ssl_verify_polarssl.c
>> +++ b/src/openvpn/ssl_verify_polarssl.c
>> @@ -137,7 +137,7 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
>>    if (!polar_ok(mpi_read_binary(&serial_mpi, cert->serial.p, cert->serial.len)))
>>      {
>>        msg(M_WARN, "Failed to retrieve serial from certificate.");
>> -      return NULL;
>> +      goto end;
>>      }
>>  
>>    /* Determine decimal representation length, allocate buffer */
>> @@ -148,9 +148,12 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
>>    if (!polar_ok(mpi_write_string(&serial_mpi, 10, buf, &buflen)))
>>      {
>>        msg(M_WARN, "Failed to write serial to string.");
>> -      return NULL;
>> +      buf = NULL;
>> +      goto end;
>>      }
>>  
>> +end:
>> +  mpi_free(&serial_mpi);
>>    return buf;
>>  }
> ACK - *but* Ivo did this work for us (Fox-IT), so some external eyes
> before applying are welcome.
>
>
ACK, looks good to me, too.

Arne



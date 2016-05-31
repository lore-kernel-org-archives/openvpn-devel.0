References: <1464694920-3624-1-git-send-email-pinkel@...277...>
	<574D81DE.1040204@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <42acc704-bb82-55b8-c087-1563b9da0586@...1227...>
Date: Tue, 31 May 2016 14:44:22 +0200
MIME-Version: 1.0
In-Reply-To: <574D81DE.1040204@...1435...>
Subject: Re: [Openvpn-devel] [PATCH master] Plug memory leak in mbedTLS
 backend
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



Am 31.05.16 um 14:21 schrieb Steffan Karger:
> On 31-05-16 13:42, Ivo Manca wrote:
>> Signed-off-by: Ivo Manca <pinkel@...277...>
>> ---
>>  src/openvpn/ssl_verify_mbedtls.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
>> index 9c4b51a..522ff68 100644
>> --- a/src/openvpn/ssl_verify_mbedtls.c
>> +++ b/src/openvpn/ssl_verify_mbedtls.c
>> @@ -162,7 +162,7 @@ backend_x509_get_serial (mbedtls_x509_crt *cert, struct gc_arena *gc)
>>        cert->serial.len)))
>>      {
>>        msg(M_WARN, "Failed to retrieve serial from certificate.");
>> -      return NULL;
>> +      goto end;
>>      }
>>  
>>    /* Determine decimal representation length, allocate buffer */
>> @@ -173,9 +173,12 @@ backend_x509_get_serial (mbedtls_x509_crt *cert, struct gc_arena *gc)
>>    if (!mbed_ok(mbedtls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen)))
>>      {
>>        msg(M_WARN, "Failed to write serial to string.");
>> -      return NULL;
>> +      buf = NULL;
>> +      goto end;
>>      }
>>  
>> +end:
>> +  mbedtls_mpi_free(&serial_mpi);
>>    return buf;
>>  }
> ACK - *but* Ivo did this work for us (Fox-IT), so some external eyes
> before applying are welcome.
>
ACK, looks good to me, too.

Arne


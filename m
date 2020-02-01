References: <CAFHpkQFTJQ_6s7Ux4G6TMye_mk+kb3P=FmOqMJYMSLBsBfXatA@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <60df855b-8821-a22f-5255-a39c0be3c8d4@...1856...>
Date: Sat, 1 Feb 2020 19:35:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFTJQ_6s7Ux4G6TMye_mk+kb3P=FmOqMJYMSLBsBfXatA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] linux arm64 tests fail
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 01-02-2020 13:43, Илья Шипицин wrote:
> https://travis-ci.org/chipitsine/openvpn/jobs/644745481?utm_medium=notification&utm_source=github_status
> 
> it indicates "ERROR" when running tests, however tests are ok after all.
> 
> [ RUN ] tls_crypt_v2_wrap_too_long_metadata
> 
> ERROR: could not crypt: insufficient space in dst
> 
> [ OK ] tls_crypt_v2_wrap_too_long_metadata
> 
> [ RUN ] tls_crypt_v2_wrap_unwrap_wrong_key
> 
> [ OK ] tls_crypt_v2_wrap_unwrap_wrong_key
> 
> [ RUN ] tls_crypt_v2_wrap_unwrap_dst_too_small
> 
> [ OK ] tls_crypt_v2_wrap_unwrap_dst_too_small
> 
> [ RUN ] test_tls_crypt_v2_write_server_key_file
> 
> [ OK ] test_tls_crypt_v2_write_server_key_file
> 
> [ RUN ] test_tls_crypt_v2_write_client_key_file
> 
> [ OK ] test_tls_crypt_v2_write_client_key_file
> 
> [==========] 14 test(s) run.
> 
> [ PASSED ] 14 test(s).
> 
> PASS: tls_crypt_testdriver

This is expected behaviour. And unrelated to arm64. Just check the amd64
build, exact same message.

We test the "too much input data" case here, which prints an error.
Looks odd, I admit. But printing warnings/errors even in tests helps
speed up diagnosis.

-Steffan


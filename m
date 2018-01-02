References: <CAKuzo_jJx0U0hEnuv=BFGm_d6ME4JP44mDCCoBPwzCBdRs+dVA@...278...>
 <1514542738-20402-1-git-send-email-steffan.karger@...1435...>
 <CAKuzo_hHXfVBAp48kjsWy5ZUT22LyfMe2rCiz8evHyJrtYw0VQ@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <99597c68-48e5-605b-695a-297258a7beb4@...1435...>
Date: Tue, 2 Jan 2018 23:48:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hHXfVBAp48kjsWy5ZUT22LyfMe2rCiz8evHyJrtYw0VQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Don't throw fatal errors from
 verify_cert_export_cert()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 02-01-18 20:19, Selva Nair wrote:
> On Fri, Dec 29, 2017 at 5:18 AM, Steffan Karger
> <steffan.karger@...1435...> wrote:
>> @@ -557,13 +557,15 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
>>      peercert_file = fopen(peercert_filename, "w+");
>>      if (!peercert_file)
>>      {
>> -        msg(M_ERR, "Failed to open temporary file : %s", peercert_filename);
>> +        msg(M_NONFATAL|M_ERRNO, "Failed to open temporary file: %s",
>> +            peercert_filename);
>>          return NULL;
>>      }
>>
>>      if (SUCCESS != x509_write_pem(peercert_file, peercert))
> 
> The openssl version of x509_write_pem() called here could fail with
> M_ERR --- is that already fixed in one of the pending patches? If not,
> why not make that one too non-fatal?

No, not fixed in the pending patches.  Good catch, will fix.

>>      {
>> -        msg(M_ERR, "Error writing PEM file containing certificate");
>> +        msg(M_NONFATAL, "Error writing PEM file containing certificate");
> 
> Yeah, not including M_ERRNO looks like the right thing to do here.
> 
>> +        peercert_filename = NULL;
> 
> This could potentially lead to a stale tempfile left behind. Could be
> fixed by unlinking here? Successfully exported cert file does get unlinked
> after the verify script returns.

Also good point, will fix.

> Sorry, earlier I only made a hasty remark about the error flag and did not do
> a proper review...

No worries, thanks for reviewing!  v3 coming soon.

-Steffan


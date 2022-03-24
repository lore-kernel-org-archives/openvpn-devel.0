Message-ID: <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
Date: Thu, 24 Mar 2022 18:48:20 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
Subject: Re: [Openvpn-devel] [PATCH] Enablement of quantum-safe key
 establishment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Michael Baentsch <info@...2666...>, openvpn-devel@lists.sourceforge.net

Am 24.03.22 um 14:40 schrieb Michael Baentsch:
> Hello,
> 
>     as per https://community.openvpn.net/openvpn/ticket/1460 the current 
> openvpn master fails when activating a TLS1.3 group implemented in an 
> external provider.
> 
> The patch attached fixes this and enables successful OpenSSL key 
> establishment using any of the quantum-safe and hybrid (classic/QSC) 
> algorithms supported by https://github.com/open-quantum-safe/oqs-provider

Thanks for the patch. Usually we would like to have patches in a git 
format that contains a commit message (see git format-patch) and 
https://github.com/OpenVPN/openvpn/blob/master/CONTRIBUTING.rst

The current patch has a few problems:

- Breaks OpenSSL 1.0.2 compatibity. Currently we still support RHEL7, 
which only has OpenSSL 1.0.2
- uses C90 variable declaration (int rc)
- indentation problems

We normally use our own gc_alloc etc usage for strings as the previous 
code did. That usage was replaced with malloc/free.

And the code does not have any comments but removes the existing ones 
and with a line like this:

memcpy(idx, f+strlen("secp256r1"), 
strlen(groups)-(f-groups)-strlen("secp256r1"));

some comments what the code is doing would improve readibility.

The fix itself is right of using the newer SSL_CTX_set1_groups_list 
function that uses strings instead of nids.

But if we use a function that only newer OpenSSL version, have you 
double checked that the prime256v1 vs secp256r1 is still necessary


Build failure with OpenSSL 1.0.2: 
https://github.com/schwabe/openvpn/runs/5680551849?check_suite_focus=true

Arne


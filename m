From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506220836.53588.nomis80@...401...> <20050622151050.GA4924@...33...>
In-Reply-To: <20050622151050.GA4924@...33...>
MIME-Version: 1.0
Message-Id: <200506221243.14297.nomis80@...401...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jun 22 09:44:23 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wednesday 22 June 2005 11:10, Matthias Andree wrote:
> Is this portable to non-GNU makes?
> If it is not, does OpenVPN require GNU make? I don't think it does.

I'm afraid it's non-portable. Damn.

> Is there a broken-out C program that fails to link at run-time if the
> workaround is required? This would be tested from configure.{in|ac} and
> set DLOPEN_PAM appropriately.

If /lib/security/pam_unix.so is missing symbols then the workaround is 
required. We could try to link a program with /lib/security/pam_unix.so and 
if the linking fails (because symbols are missing) then the workaround is 
needed. Here's an example:

[nomis80@...423... ~]$ gcc main.c /lib/security/pam_unix.so
[nomis80@...423... ~]$ gcc main.c /lib/security/pam_smb_auth.so
/lib/security/pam_smb_auth.so: undefined reference to `pam_get_item'
/lib/security/pam_smb_auth.so: undefined reference to `pam_set_item'
/lib/security/pam_smb_auth.so: undefined reference to `pam_get_user'
collect2: ld returned 1 exit status

main.c contains this: int main() { return 0; }
On my system, pam_unix.so is not missing symbols while pam_smb_auth.so is.

I tried to find a way to check this using autoconf but I'm not very good with 
it. Maybe you can do it in a few minutes... ;)


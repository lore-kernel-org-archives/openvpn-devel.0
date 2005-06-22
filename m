From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <20050622182551.GA15138@...33...> <200506221459.16684.nomis80@...401...>
In-Reply-To: <200506221459.16684.nomis80@...401...>
MIME-Version: 1.0
Message-Id: <200506221515.36785.nomis80@...401...>
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
Date: Wed Jun 22 12:16:42 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wednesday 22 June 2005 14:59, Simon Perreault wrote:
> I've also rebuilt the RPM (on a FC4 system, because I
> deleted my SUSE 9.1 vmware) and my rebuilt RPM does not have the bug!

AH! I understand now! Even though pam_unix.so is *built* in the pam RPM, it is 
not *included* in the RPM. The real pam_unix.so comes from pam-modules and 
this one doesn't link against PAM. That's a bug that should be reported to 
SUSE.


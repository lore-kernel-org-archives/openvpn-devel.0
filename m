Message-ID: <406AEE98.30801@...177...>
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
Subject: [Openvpn-devel] small patch for the spec.in file
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
Date: Wed Mar 31 08:16:07 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi,
here is my small patch for the spec.in file in order not to overwrite 
the old config files.

--- openvpn.spec.in.lfarkas     2004-03-31 18:11:14.000000000 +0200
+++ openvpn.spec.in     2004-03-31 18:13:25.000000000 +0200
@@ -34,9 +34,9 @@
  %__install -c -m 755 %{name}.8 %{buildroot}%{_mandir}/man8
  %__install -c -d -m 755 %{buildroot}%{_sbindir}
  %__install -c -m 755 %{name} %{buildroot}%{_sbindir}
-%__install -c -d -m 755 %{buildroot}/etc/rc.d/init.d
-%__install -c -m 755 sample-scripts/%{name}.init 
%{buildroot}/etc/rc.d/init.d/%{name}
-%__install -c -d -m 755 %{buildroot}/etc/%{name}
+%__install -c -d -m 755 %{buildroot}%{_initrddir}
+%__install -c -m 755 sample-scripts/%{name}.init 
%{buildroot}%{_initrddir}/%{name}
+%__install -c -d -m 755 %{buildroot}%{_sysconfdir}/%{name}

  %__mkdir_p %{buildroot}%{_datadir}/%{name}
  %__cp -pr contrib easy-rsa sample-{config-file,key,script}s 
%{buildroot}%{_datadir}/%{name}
@@ -67,9 +67,12 @@
  %{_mandir}/man8/%{name}.8*
  %{_sbindir}/%{name}
  %{_datadir}/%{name}
-/etc
+%config(noreplace) %{_sysconfdir}

  %changelog
+* Mon Mar 31 2004 Levente Farkas <lfarkas@...193...> 2.0_test18
+- Mark config file as config.
+
  * Sun Feb 23 2003 Matthias Andree <matthias.andree@...68...> 1.3.2.14-1.
  - Have the version number filled in by autoconf.


-- 
   Levente                               "Si vis pacem para bellum!"


